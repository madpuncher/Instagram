//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowStats)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

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
    
    private var models = [UserNotification]()

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
        fetchNotification()
        
    }
    
    private func fetchNotification() {
        for i in 1...100 {
            
            let user = User(username: "", bio: "", name: ("",""), profilePhoto: URL(string: "https://vk.com/im")!, birthDate: Date(), gender: .male, count: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
            
            let post = UserPost(id: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], postedDate: Date(), taggedUsers: [], owner: user)
            
            let model = UserNotification(type: i % 2 == 0 ? .like(post: post) : .follow(state: .following), text: "Hi mir aga lolo", user: User(username: "@eldar_tengizov", bio: "", name: (first: "", last: ""), profilePhoto: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, count: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date()))
            
            models.append(model)
        }
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
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        
        switch model.type {
        
        case .like(post: _):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikesTableViewCell.identifier, for: indexPath) as! NotificationLikesTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
            
        case .follow:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowTableViewCell.identifier, for: indexPath) as! NotificationFollowTableViewCell
            
//            cell.configure(with: model)
            cell.delegate = self
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NotificationsViewController: NotificationLikeDelegate {
    
    func didTapPostButton(model: UserNotification) {
        
        switch model.type {
        
        case .like(post: let post):
            
            let vc = PostViewController(model: nil)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(state: _):
            fatalError()
        }
        
    }
}

extension NotificationsViewController: NotificationFollowDelegate {
    
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("tup follow button")
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
