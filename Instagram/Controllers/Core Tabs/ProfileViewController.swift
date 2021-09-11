//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

///Profile view controller
final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "eldar_tengizov"
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addutton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.square"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)

        setupNavigationBar()
                        
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
        collectionView?.backgroundColor = .systemBackground
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 3 , height: view.bounds.width / 3)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView?.register(ProfileInfoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
                
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collection = collectionView else { return }
        
        view.addSubview(collection)
    }
    
    //MARK: Setup UI
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .label
                
        let titleView = UIView()
        titleView.backgroundColor = .systemBackground
        titleView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let chevronDown = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronDown.tintColor = .label
        chevronDown.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [nameLabel, chevronDown, addutton, settingsButton])
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.setCustomSpacing(90, after: chevronDown)
        stackview.setCustomSpacing(15, after: addutton)
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(stackview)

        navigationItem.titleView = titleView
    }
    
    @objc private func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.backgroundColor = .label
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct ProfileControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: ProfileViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
