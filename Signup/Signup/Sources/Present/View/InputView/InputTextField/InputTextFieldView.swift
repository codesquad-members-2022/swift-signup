//
//  InputTextFieldView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import Combine
import UIKit

class InputTextFieldView: InputView, InputTextField {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.addLeftPadding(10)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        return textField
    }()
    
    
    var textPublisher: AnyPublisher<String, Never> {
        textField.textPublisher()
    }
    
    var placeholder: String = "" {
        didSet {
            self.textField.placeholder = placeholder
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var textContentType: UITextContentType = .name {
        didSet {
            textField.textContentType = textContentType
        }
    }
    
    override init() {
        super.init()
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
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
        self.optionView.addSubview(textField)
        textField.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
    }
    
    func setSubMessage(_ isError: Bool, _ message: String) {
        let color: UIColor = !isError ? .systemRed : .systemGreen
        self.subLabel.isHidden = message.isEmpty
        self.subLabel.text = message
        self.subLabel.textColor = color
        self.textField.layer.borderColor = color.cgColor
    }
}
