//
//  FeedGeneralTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import UIKit

/// Comments
class FeedGeneralTableViewCell: UITableViewCell {

    static let identifier = "FeedGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct FeedGeneralCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: HomeViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

