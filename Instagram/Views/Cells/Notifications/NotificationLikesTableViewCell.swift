//
//  NotificationLikesTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 15.09.2021.
//

import UIKit

protocol NotificationLikeDelegate: AnyObject {
    func didTapPostButton(model: String)
}

class NotificationLikesTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikesTableViewCell"
        
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
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("Подписаться", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: NotificationLikeDelegate?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(postButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postButton.setBackgroundImage(nil, for: .normal)
        nameLabel.text = nil
        profileImageView.image = nil
    }
    
    func configure() {
        
    }
}
