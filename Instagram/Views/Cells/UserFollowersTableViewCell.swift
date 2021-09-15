//
//  UserFollowersTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 14.09.2021.
//

import UIKit

protocol UserFollowersTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(model: userRelationships)
    func didTapFollowUnfollowButton(model: userRelationships)
}

enum FollowStats {
    case following, notFollowing
}

struct userRelationships {
    let username: String
    let name: String
    let type: FollowStats
}

class UserFollowersTableViewCell: UITableViewCell {

    static let identifier = "UserFollowersTableViewCell"
    
    private let profileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "test"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "eldar_tengieqwewqeqezov"
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Eldar Tengizov"
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let deleteButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Удалить", for: .normal)
//        button.setTitleColor(.label, for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.secondaryLabel.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    private let unfollowButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Вы подписаны", for: .normal)
//        button.setTitleColor(.label, for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.secondaryLabel.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подписаться", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var model: userRelationships?
    
    weak var delegate: UserFollowersTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageView.bounds.height).isActive = true
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func followButtonTapped() {
        guard let model = model else { return }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    func configure(with model: userRelationships) {
        
        self.model = model
        
        nameLabel.text = model.name
        userNameLabel.text = model.username
        
        switch model.type {
        
        case .following:
            
            followButton.setTitle("Вы подписаны", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            followButton.translatesAutoresizingMaskIntoConstraints = false
            
        case .notFollowing:
            
            followButton.setTitle("Подписаться", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.cornerRadius = 5
            followButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            followButton.backgroundColor = .systemBlue
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil 
    }
    
    private func setupConstraints() {
        addSubview(profileImageView)
//        addSubview(deleteButton)
        addSubview(followButton)
//        addSubview(unfollowButton)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, userNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 65),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 39),
            stackView.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -10),
            
            followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            followButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: self.bounds.width / 2)
        ])
        
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct UserFollowersControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
           UINavigationController(rootViewController: ListViewController(data: []))
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}



