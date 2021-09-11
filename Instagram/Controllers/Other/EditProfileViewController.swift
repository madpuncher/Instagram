//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        
    }

    @objc private func cancelButtonTapped() {
        
    }
    
    @objc private func changeProfilePicture() {
        let actionSheet = UIAlertController(title: "Картинка профиля", message: "Изменить картинку", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { _ in
            //
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            //
        }))
        
        present(actionSheet, animated: true)
    }
}

//MARK: Preview
import SwiftUI

struct EditProfilerovider_Preview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: EditProfileViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
