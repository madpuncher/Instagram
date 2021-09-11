//
//  PrivacySettingsViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import UIKit

class PrivacySettingsViewController: UIViewController {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Данный экран не настроен. Возможно, что он появится в будущем"
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .boldSystemFont(ofSize: 25)
        label.minimumScaleFactor = 0.5
        label.allowsDefaultTighteningForTruncation = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Личная информация"
        
        navigationController?.navigationBar.tintColor = UIColor.label
    }
}

//MARK: Preview
import SwiftUI

struct PrivacySettingsProvider_Preview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: PrivacySettingsViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
