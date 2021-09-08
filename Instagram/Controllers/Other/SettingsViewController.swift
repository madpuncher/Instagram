//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "signOutCell")
        return tableView
    }()
    
    var userName: String? = "eldar_tengizov"

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let noAction = UIAlertAction(title: "Нет", style: .destructive, handler: nil)

        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            
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
                
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }

}

//MARK: TABLE VIEW DATA SOURCE AND DELEGATE
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signOutCell", for: indexPath)
        cell.textLabel?.text = "Выйти из аккаунта \(userName ?? "")"
        cell.imageView?.image = UIImage(systemName: "person.circle")
        cell.tintColor = .label
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        showSingOutAlert()
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
