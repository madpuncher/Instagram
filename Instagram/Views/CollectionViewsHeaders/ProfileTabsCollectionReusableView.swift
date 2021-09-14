//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import UIKit

protocol ProfileTabsCollectionReusableViewsDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileTabsCollectionReusableView"
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "rectangle.split.3x3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "person.crop.square"), for: .normal)
        return button
    }()

    weak var delegate: ProfileTabsCollectionReusableViewsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(taggedButtonTapped), for: .touchUpInside)

        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(gridButton)
        addSubview(taggedButton)
        
        NSLayoutConstraint.activate([
            
            gridButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (self.bounds.width / 2) / 2),
            gridButton.heightAnchor.constraint(equalToConstant: 30),
            gridButton.widthAnchor.constraint(equalToConstant: 30),
            gridButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            taggedButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.bounds.width / 2) / 2),
            taggedButton.widthAnchor.constraint(equalToConstant: 30),
            taggedButton.heightAnchor.constraint(equalToConstant: 30),
            taggedButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

        ])
        
    }
    
    @objc private func gridButtonTapped() {
        gridButton.tintColor = .label
        taggedButton.tintColor = .secondaryLabel
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func taggedButtonTapped() {
        gridButton.tintColor = .secondaryLabel
        taggedButton.tintColor = .label
        delegate?.didTapTaggedButtonTab()
    }
    
}

//MARK: Preview
import SwiftUI

struct ProfileTabsProvider_Preview: PreviewProvider {
    
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

