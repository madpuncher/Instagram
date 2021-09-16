//
//  NotificationFollowTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 15.09.2021.
//

import UIKit

protocol NotificationFollowDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowTableViewCell"
        
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "@holu_hola12 подписался(-ась) на ваши обновления"
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подписаться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: NotificationFollowDelegate?

    private var model: UserNotification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        addSubview(profileImageView)
        addSubview(infoTextLabel)
        addSubview(followButton)
        
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
        setupConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    }
    
    @objc private func followButtonTapped() {
        
        guard let model = model else { return }
        
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            followButton.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.4),
            followButton.widthAnchor.constraint(equalToConstant: self.bounds.width / 2.5),
            followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            followButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            infoTextLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            infoTextLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -15),
            infoTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
    
    func configure(with model: UserNotification) {
        self.model = model
                
        switch model.type {
        
        case .like(post: _):
            break
        case .follow(let state):
            
            switch state {
            
            case .following:
                
                followButton.setTitle("Вы подписаны", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.backgroundColor = .systemBackground
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
                
            case .notFollowing:
                
                followButton.setTitle("Подписаться", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.cornerRadius = 5
                followButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
                followButton.backgroundColor = .systemBlue
            }
            
            break
        }
        
        infoTextLabel.text = model.text
        
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
}

import SwiftUI

struct NotificationFollowsProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
           UINavigationController(rootViewController: NotificationsViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}



