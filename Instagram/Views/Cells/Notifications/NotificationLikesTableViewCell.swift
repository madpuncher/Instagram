//
//  NotificationLikesTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 15.09.2021.
//

import SDWebImage
import UIKit

protocol NotificationLikeDelegate: AnyObject {
    func didTapPostButton(model: UserNotification)
}

class NotificationLikesTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikesTableViewCell"
        
    private let profileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "test"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemBackground
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let textInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "@eldar_tengizov нравится ваше фото"
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: NotificationLikeDelegate?
    
    private var model: UserNotification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        addSubview(profileImageView)
        addSubview(textInfoLabel)
        addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        
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
    
    @objc private func postButtonTapped() {
        
        guard let model = model else {
            return
        }
        
        delegate?.didTapPostButton(model: model)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            postButton.heightAnchor.constraint(equalToConstant: 50),
            postButton.widthAnchor.constraint(equalToConstant: 50),
            postButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            postButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            textInfoLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            textInfoLabel.trailingAnchor.constraint(equalTo: postButton.leadingAnchor, constant: -15),
            textInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
    
    func configure(with model: UserNotification) {
        self.model = model
                
        switch model.type {
        
        case .like(post: let post):
            
            let thumbnail = post.thumbnailImage
            
            guard !thumbnail.absoluteString.contains("google.com") else { return }
            
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
            
        case .follow:
            break
        }
        
        textInfoLabel.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
}

//MARK: Setup Canvas
import SwiftUI

struct NotificationLikesProvider: PreviewProvider {
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



