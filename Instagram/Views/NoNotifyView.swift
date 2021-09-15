//
//  NoNotifyView.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 15.09.2021.
//

import UIKit

class NoNotifyView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "У вас нет уведомлений"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .secondaryLabel
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "bell")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.frame = CGRect(x: (bounds.width - 50) / 2, y: 0, width: 50, height: 50).integral
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: self.bounds.width)
        ])
    }
}
