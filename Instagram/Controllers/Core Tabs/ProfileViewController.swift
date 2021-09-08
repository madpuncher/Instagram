//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
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

        setupNavigationBar()

        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
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
