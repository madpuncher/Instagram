//
//  LoginViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameEmailTF: UITextField = {
        var tf = UITextField()
        tf.returnKeyType = .next
        tf.textColor = .label
        tf.borderStyle = .roundedRect
        tf.attributedPlaceholder = NSAttributedString(string: "Имя пользователя или электронный адрес", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.leftViewMode = .always
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.backgroundColor = .secondarySystemBackground
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTF: UITextField = {
        var tf = UITextField()
        tf.returnKeyType = .join
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.leftViewMode = .always
        tf.autocapitalizationType = .none
        tf.backgroundColor = .secondarySystemBackground
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    private let headerView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Logo"))
        view.contentMode = .scaleAspectFit
        view.tintColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.3988033421)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрируйтесь", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let haventAcc: UILabel = {
        let label = UILabel()
        label.text = "У вас нет аккаунта?"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        usernameEmailTF.delegate = self
        passwordTF.delegate = self
        setupConstraints()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Frames...
    }
    
    //MARK: ACTIONS FOR BUTTONS
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        view.addSubview(headerView)
        view.addSubview(usernameEmailTF)
        view.addSubview(passwordTF)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(footerView)
        
        let stackview = UIStackView(arrangedSubviews: [haventAcc, registerButton])
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameEmailTF.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            usernameEmailTF.heightAnchor.constraint(equalToConstant: 50),
            usernameEmailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameEmailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            passwordTF.topAnchor.constraint(equalTo: usernameEmailTF.bottomAnchor, constant: 15),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTF.trailingAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 14),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            footerView.bottomAnchor.constraint(equalTo: stackview.topAnchor, constant: -5),
            
            stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackview.heightAnchor.constraint(equalToConstant: 40),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])

    }
    
    //MARK: Button actions
    @objc private func loginButtonTapped() {
        usernameEmailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        guard
            usernameEmailTF.text?.isEmpty == false,
            passwordTF.text?.isEmpty == false,
            let usernameEmail = usernameEmailTF.text,
            let password = passwordTF.text else { return }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        //Login func
        AuthManager.shared.loginUser(username: username,
                                     email: email,
                                     password: password) { [self] success in
            DispatchQueue.main.async {
                if success {
                    //LOGIN
                    dismiss(animated: true, completion: nil)
                } else {
                    //ERROR
                    
                    self.passwordTF.text = ""
                    
                    let alert = UIAlertController(title: "Ошибка входа",
                                                  message: "Вы ввели неверный логин или пароль",
                                                  preferredStyle: .alert)
                    let alertOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(alertOkAction)
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func forgotPasswordButtonTapped() {
        
    }
    
    @objc private func registerButtonTapped() {
        let registerVC = RegistrationViewController()
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }

}

//MARK: TEXTFIELD DELEGATE
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: Preview
import SwiftUI

struct LoginViewProvider_Preview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
//            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            LoginViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
