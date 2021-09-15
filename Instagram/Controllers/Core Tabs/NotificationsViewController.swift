//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = false
        table.register(NotificationFollowTableViewCell.self, forCellReuseIdentifier: NotificationFollowTableViewCell.identifier)
        table.register(NotificationLikesTableViewCell.self, forCellReuseIdentifier: NotificationLikesTableViewCell.identifier)
        return table
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Действия"
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotifyView = NoNotifyView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
//        spinner.startAnimating()
        
        view.addSubview(spinner)
        view.addSubview(tableView)
        
        setupNavBar()
        
    }
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let titleView = UIView()
        titleView.backgroundColor = .systemBackground
        titleView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 50)
        
        titleView.addSubview(headerLabel)
        
        navigationItem.titleView = titleView
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.tableFooterView = UIView()
        tableView.frame = view.bounds
        
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func layoutNoNotify() {
        
        tableView.isHidden = true
        view.addSubview(noNotifyView)
        
        noNotifyView.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 1.2, height: view.bounds.width / 2)
        noNotifyView.center = view.center
    }

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath)
        
        return cell
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct NotificationsControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: NotificationsViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
