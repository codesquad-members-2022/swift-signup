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
    
    var changedPublisher: AnyPublisher<String, Never> {
        textField.changedPublisher()
    }
    
    var beginEditionPublisher: AnyPublisher<Void, Never> {
        textField.publisher(for: .editingDidBegin)
    }
    
    var endEditionPublisher: AnyPublisher<Void, Never> {
        textField.publisher(for: .editingDidEnd)
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
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    var cancale = Set<AnyCancellable>()
    
    private func layout() {
        self.optionView.addSubview(textField)
        textField.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
    }
    
    func setMessage(_ isError: Bool, _ message: String) {
        if message.isEmpty {
            self.textField.layer.borderColor = UIColor.systemGray2.cgColor
            self.subLabel.isHidden = true
            return
        }
        let color: UIColor = !isError ? .systemRed : .systemGreen
        self.subLabel.isHidden = message.isEmpty
        self.subLabel.text = message
        self.subLabel.textColor = color
        self.textField.layer.borderColor = color.cgColor
    }
    
    func setFocused(_ isFocused: Bool) {
        self.textField.layer.borderColor = isFocused ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
}
