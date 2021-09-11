//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit

struct EditProfileModel {
    let label: String
    var value: String?
}

class EditProfileViewController: UIViewController, FormTableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormsTableViewCell.self, forCellReuseIdentifier: FormsTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [EditProfileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()

        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.tableHeaderView = setupHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func didUpdateValues(cell: FormsTableViewCell, didUpdateField model: EditProfileModel) {
        //
    }
    
    private func configureModels() {
        
        let sectionLabels = ["Имя", "Имя пользователя", "О себе"]
        
        for label in sectionLabels {
            let model = EditProfileModel(label: label, value: nil)
            models.append(model)
        }
        
    }
    
    private func setupNavBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(saveButtonTapped))
        
        let leftItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(cancelButtonTapped))
        leftItem.tintColor = .label
        
        navigationItem.leftBarButtonItem = leftItem
        
        title = "Редактировать профиль"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        ]
        
    }
    
    private func setupHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4.5))
        
        let size = header.bounds.height / 1.5
        
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.bounds.width - size) / 2, y: (header.bounds.height - size) / 2, width: size, height: size))
        
        let button = UIButton(type: .system)
        button.setTitle("Изменить фото профиля", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.addTarget(self, action: #selector(changeProfilePicture), for: .touchUpInside)
        
        header.addSubview(profilePhotoButton)
        header.addSubview(button)
        
        button.topAnchor.constraint(equalTo: profilePhotoButton.bottomAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2
        profilePhotoButton.addTarget(self, action: #selector(changeProfilePicture), for: .touchUpInside)
        
        profilePhotoButton.setBackgroundImage(UIImage(named: "empty"), for: .normal)
        
        return header
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func changeProfilePicture() {
        let actionSheet = UIAlertController()
        
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
    
    @objc private func openPrivacySettings() {
        navigationController?.pushViewController(PrivacySettingsViewController(), animated: true)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormsTableViewCell.identifier, for: indexPath) as! FormsTableViewCell
        
        let model = models[indexPath.row]
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44.0))
        let doneButton = UIButton(type: .system)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
                
        doneButton.setTitle("Настройки личной информации", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        doneButton.addTarget(self, action: #selector(openPrivacySettings), for: .touchUpInside)
        
        footerView.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10)
        ])
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
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
