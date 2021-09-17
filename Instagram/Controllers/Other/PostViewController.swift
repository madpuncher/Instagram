//
//  PostViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

/// States  of  a render cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}

/// Model of rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedHeaderTableViewCell.self, forCellReuseIdentifier: FeedHeaderTableViewCell.identifier)
        tableView.register(FeedActionsTableViewCell.self, forCellReuseIdentifier: FeedActionsTableViewCell.identifier)
        tableView.register(FeedGeneralTableViewCell.self, forCellReuseIdentifier: FeedGeneralTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        guard let userPostModel = model else { return }
        // HEADER
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        //POST
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        //ACTIONS
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        //COMMENTS
        
        var comments = [PostComment]()
        
        for x in 0..<4 {
            comments.append(PostComment(id: "312321\(x)", username: "@elfew", comment: "Wow cool!!!", createdDate: Date(), likes: []))
        }
        
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    private func setupNavBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            
        case .header(provider: _):
            return 1
        case .primaryContent(provider: _):
            return 1
        case .actions(provider: _):
            return 1
        case .comments(comments: let comments):
            return comments.count > 4 ? 4 : comments.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        
        case .header(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedHeaderTableViewCell.identifier, for: indexPath) as! FeedHeaderTableViewCell
            
            return cell
        case .primaryContent(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as! FeedPostTableViewCell
            
            return cell
        case .actions(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedActionsTableViewCell.identifier, for: indexPath) as! FeedActionsTableViewCell
            
            return cell
        case .comments(comments: let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedGeneralTableViewCell.identifier, for: indexPath) as! FeedGeneralTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        
        case .header(provider: _): return 70
        case .primaryContent(provider: _): return tableView.bounds.width
        case .actions(provider: _): return 60
        case .comments(comments: _): return 50
            
        }
    }
    
}

//MARK: Preview
import SwiftUI

struct PostProvider_Preview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
            .preferredColorScheme(.dark)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: PostViewController(model: UserPost(id: "", postType: .photo, thumbnailImage: URL(string: "https://vk.com/im")!, postURL:  URL(string: "https://vk.com/im")!, caption: "", likeCount: [], comments: [], postedDate: Date(), taggedUsers: [], owner: User(username: "", bio: "", name: ("",""), profilePhoto: URL(string: "https://vk.com/im")!, birthDate: Date(), gender: .male, count: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date()))))
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
