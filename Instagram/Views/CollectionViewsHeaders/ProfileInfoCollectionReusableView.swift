//
//  ProfileInfoCollectionReusableView.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    
    func profileHeaderDidTapPostButton(_ header: ProfileInfoCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoCollectionReusableView)
    func profileHeaderDidTapSubsribeButton(_ header: ProfileInfoCollectionReusableView)
    func profileHeaderDidTapEditButton(_ header: ProfileInfoCollectionReusableView)
}

class ProfileInfoCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoCollectionReusableView"
    
    weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "test")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Публикации", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подписчики", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let subscribesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подписки", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать профиль", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Eldar Tengizov"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerLine: UIView = {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        footer.heightAnchor.constraint(equalToConstant: 2).isActive = true
        footer.tintColor = .secondaryLabel
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Tut buder info po useru, check number of lines bla bla bla bla lya lya lya lya check check check check"
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        
        postsButton.addTarget(self, action: #selector(postsButtonTapped), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(followersButtonTapped), for: .touchUpInside)
        subscribesButton.addTarget(self, action: #selector(subscriberButtonTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.bounds.height / 2
        profilePhotoImageView.widthAnchor.constraint(equalToConstant: profilePhotoImageView.bounds.height).isActive = true
    }
    
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [postsButton, followersButton, subscribesButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profilePhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            profilePhotoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: self.bounds.height / 2.6),
            
            stackView.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor),
            
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            editButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: self.bounds.width - 20),
            editButton.heightAnchor.constraint(equalToConstant: 35),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 15),
            
            bioLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            bioLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
        ])
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(subscribesButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(editButton)
        addSubview(footerLine)
    }
    
    //MARK: ACTIONS
    
    @objc private func postsButtonTapped() {
        delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc private func followersButtonTapped() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func subscriberButtonTapped() {
        delegate?.profileHeaderDidTapSubsribeButton(self)
    }
    
    @objc private func editButtonTapped() {
        delegate?.profileHeaderDidTapEditButton(self)
    }
    
}

//MARK: Preview
import SwiftUI

struct ProfileInfoProvider_Preview: PreviewProvider {
    
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
