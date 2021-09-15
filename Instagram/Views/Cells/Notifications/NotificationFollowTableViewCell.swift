//
//  NotificationFollowTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 15.09.2021.
//

import UIKit

protocol NotificationFollowDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: String)
}

class NotificationFollowTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowTableViewCell"
        
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
    
    var delegate: NotificationFollowDelegate?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        nameLabel.text = nil
        profileImageView.image = nil 
    }
    
    func configure() {
        
    }
}
