//
//  SignUpInputViewComponent.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpInputView:UIView,SignUpInputViewable {
    
    var delegate:SignUpInputTextFieldDelegate?
    
    private var identifier:inputViewIdentifierable?
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var textField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    private lazy var validatedTextLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10,weight: .light)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func getTextFieldText() -> String? {
        return self.textField.text
    }
    
    func labelText(text:String) {
        self.label.text = text
    }
    
    func placeholder(text:String) {
        self.textField.placeholder = text
    }
    
    func setIdentifier(id:inputViewIdentifierable) {
        self.identifier = id
    }
    
    func getIdentifier() -> inputViewIdentifierable? {
        return self.identifier ?? nil
    }
    
    func setAlertText(text:String) {
        self.validatedTextLabel.text = text
    }
    
    
    private func setUp() {
        let space:CGFloat = 8.0
        let textFieldHeight:CGFloat = 32.0
        [label,textField,validatedTextLabel].forEach{ self.addSubview($0) }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        validatedTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: label.bottomAnchor,constant: space).isActive = true
        textField.heightAnchor.constraint(equalToConstant:textFieldHeight).isActive = true
        
        validatedTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        validatedTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        validatedTextLabel.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
    }
}

extension SignUpInputView:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = identifier else { return }
        delegate?.textFieldEndEditing(inputViewID: identifier, textField: textField)
    }
}
