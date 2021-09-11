//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import SafariServices
import UIKit

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "signOutCell")
        return tableView
    }()
    
    var userName: String? = "eldar_tengizov"
    
    var tableViewCellModels = [SettingsCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModel()
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
    }
    
    //MARK: Setup UI
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Настройки"
    }
    
    //MARK: ALERTS
    private func showSingOutAlert() {
        let alert = UIAlertController(title: "Выход из аккаунта", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)

        let yesAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            
            //Leave from account
            AuthManager.shared.logOut { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        let loginVC  = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self?.present(loginVC, animated: true) {
                            self?.navigationController?.popToRootViewController(animated: false)
                            self?.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        //Alert
                    }
                }
            }
        }
                
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Models and functions
    private func configureModel() {
        tableViewCellModels.append(contentsOf: [
            SettingsCellModel(title: "Аккаунт", image: "person.circle") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingsCellModel(title: "Подписки и приглашения", image: "person.crop.circle.badge.plus") { [weak self] in
                self?.didTapInvite()
            },
            SettingsCellModel(title: "Сохранить пост", image: "square.and.arrow.down") { [weak self] in
                self?.didTapSavePost()
            },
            SettingsCellModel(title: "Информация", image: "questionmark.circle") { [weak self] in
                self?.openURL(type: .info)
            },
            SettingsCellModel(title: "Помощь", image: "message.circle") { [weak self] in
                self?.openURL(type: .help)
            },
            SettingsCellModel(title: "Выйти из аккаунта", image: "arrow.uturn.backward") { [weak self] in
                self?.showSingOutAlert()
            },
        ])
    }
    
    enum SettingsURLTypes {
        case info, help
    }
    
    private func openURL(type: SettingsURLTypes) {
        
        var urlString = ""
        
        switch type {
        case .info:
            urlString = "https://help.instagram.com/581066165581870"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSavePost() {
        
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Настройка профиля"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInvite() {
        
    }

}

//MARK: TABLE VIEW DATA SOURCE AND DELEGATE
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signOutCell", for: indexPath)
        
        let model = tableViewCellModels[indexPath.item]
        
        cell.textLabel?.text = model.title
        
        cell.imageView?.image = UIImage(systemName: model.image!)
        
        if model.title == "Выйти из аккаунта" {
            cell.tintColor = .systemBlue

        } else {
            cell.tintColor = .label
        }
        
        if model.title == "Выйти из аккаунта" {
            cell.textLabel?.textColor = .systemBlue

        } else {
            cell.textLabel?.textColor = .label
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewCellModels[indexPath.row].completion()
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: SettingsViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
