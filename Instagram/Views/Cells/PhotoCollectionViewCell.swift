//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "test"))
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open photo"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with model: UserPost) {
        let url = model.thumbnailImage
        imageView.sd_setImage(with: url, completed: nil)
   
    }
    
    func configure(debug imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

//MARK: Setup Canvas
import SwiftUI

struct PhotoCollectionControllerProvider: PreviewProvider {
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
