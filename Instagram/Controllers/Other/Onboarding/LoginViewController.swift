//
//  LoginViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameEmailTF: UITextField = {
        let tf = UITextField()
        
        return tf
    }()
    
    private let passworfTF: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Frames...
    }
    
    private func setupConstraints() {
        view.addSubview(headerView)
        view.addSubview(usernameEmailTF)
        view.addSubview(passworfTF)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(registerButton)

    }
    
    //MARK: Button actions
    @objc private func loginButtonTapped() {
        
    }
    
    @objc private func forgotPasswordButtonTapped() {
        
    }
    
    @objc private func registerButtonTapped() {
        
    }

}

//MARK: Preview
import SwiftUI

struct LoginViewProvider_Preview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            LoginViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
