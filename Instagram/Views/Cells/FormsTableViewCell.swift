//
//  FormsTableViewCell.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 11.09.2021.
//

import UIKit

protocol FormTableViewDelegate: AnyObject {
    func didUpdateValues(cell: FormsTableViewCell, didUpdateField model: EditProfileModel)
}

class FormsTableViewCell: UITableViewCell {

    static let identifier = "formCell"
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var model: EditProfileModel?
    
    weak var delegate: FormTableViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        
        textField.delegate = self
        
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            formLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            formLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            formLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 4),
            
            textField.leadingAnchor.constraint(equalTo: formLabel.trailingAnchor, constant: 5),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(with model: EditProfileModel) {
        formLabel.text = model.label
        self.model = model
        
        if model.label == "Имя" {
            textField.placeholder = "Введите своё имя"
        } else if model.label == "Имя пользователя" {
            textField.placeholder = "Придумайте себе пользовательское имя"
        } else {
            textField.placeholder = "Введи любую информацию о себе"
        }
        
        textField.text = model.value
    }
    
}

extension FormsTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        model?.value = textField.text
        guard let model = model else { return true }
        
        delegate?.didUpdateValues(cell: self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Preview
import SwiftUI

struct FormsTableProvider_Preview: PreviewProvider {
    
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
