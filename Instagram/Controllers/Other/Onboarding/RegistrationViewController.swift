//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let headerLabel: UILabel = {
        let header = UILabel()
        header.text = "Введите адрес электронной почты, ваш никнейм и пароль"
        header.textColor = .label
        header.font = .boldSystemFont(ofSize: 20)
        header.numberOfLines = 0
        header.textAlignment = .center
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let emailTF: UITextField = {
        var tf = UITextField()
        tf.returnKeyType = .next
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.layer.borderColor = UIColor.white.cgColor
        tf.attributedPlaceholder = NSAttributedString(string: "Ваша почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.leftViewMode = .always
        tf.autocapitalizationType = .none
        tf.backgroundColor = .secondarySystemBackground
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let usernameTF: UITextField = {
        var tf = UITextField()
        tf.returnKeyType = .next
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.attributedPlaceholder = NSAttributedString(string: "Ваш никнейм", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.leftViewMode = .always
        tf.autocapitalizationType = .none
        tf.backgroundColor = .secondarySystemBackground
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTF: UITextField = {
        var tf = UITextField()
        tf.returnKeyType = .join
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Пароль ( Не менее 6 символов ) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.leftViewMode = .always
        tf.autocapitalizationType = .none
        tf.backgroundColor = .secondarySystemBackground
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.3988033421)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let haventAcc: UILabel = {
        let label = UILabel()
        label.text = "У вас уже есть аккаунт?"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        setupConstraints()
    }
    
    @objc private func registerButtonTapped() {
        guard
            let email = emailTF.text, !email.isEmpty,
            let username = usernameTF.text, !username.isEmpty,
            let password = passwordTF.text, !password.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { register in
            DispatchQueue.main.async {
                if register {
                    
                } else {
                    
                }
            }
        }
        
    }
    
    @objc private func loginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    private func setupConstraints() {
        
        view.addSubview(headerLabel)
        view.addSubview(emailTF)
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(registerButton)
        view.addSubview(footerView)
        view.addSubview(backButton)

        let stackview = UIStackView(arrangedSubviews: [haventAcc, loginButton])
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            headerLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.3),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTF.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            usernameTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 20),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            passwordTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            registerButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            footerView.bottomAnchor.constraint(equalTo: stackview.topAnchor, constant: -5),
            
            stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackview.heightAnchor.constraint(equalToConstant: 40),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}


//MARK: TEXTFIELD DELEGATE
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            usernameTF.becomeFirstResponder()
        } else if textField == usernameTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

//MARK: PREVIEW

import SwiftUI

struct RegistrationVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            RegistrationViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
