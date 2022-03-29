//
//  InputView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import UIKit
import Combine

class InputView: UIView {    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.addLeftPadding()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        return textField
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    var textPublisher: AnyPublisher<String, Never> {
        textField.textPublisher()
    }
    
    var title: String {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    var placeholder: String {
        didSet {
            self.textField.placeholder = placeholder
        }
    }
    
    var isSecureTextEntry: Bool {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var textContentType: UITextContentType {
        didSet {
            textField.textContentType = textContentType
        }
    }
    
    init() {
        self.title = ""
        self.placeholder = ""
        self.isSecureTextEntry = false
        self.textContentType = .name
        super.init(frame: .zero)
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        self.title = ""
        self.placeholder = ""
        self.isSecureTextEntry = false
        self.textContentType = .name
        super.init(coder: coder)
        bind()
        layout()
    }
    
    private func bind() {
        NotificationCenter.default.addObserver(forName: UITextField.textDidBeginEditingNotification, object: self.textField, queue: nil) { _ in
            self.textField.layer.borderColor = UIColor.systemBlue.cgColor
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidEndEditingNotification, object: self.textField, queue: nil) { _ in
            self.textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.addSubview(textField)
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.addSubview(subLabel)
        subLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.bottomAnchor.constraint(equalTo: subLabel.bottomAnchor).isActive = true
    }
    
    func setMessage(_ type: SignUpModel.MessageType, _ message: String) {
        let color: UIColor = type == .error ? .systemRed : .systemGreen
        self.subLabel.isHidden = message.isEmpty
        self.subLabel.text = message
        self.subLabel.textColor = color
        self.textField.layer.borderColor = color.cgColor
    }
}
