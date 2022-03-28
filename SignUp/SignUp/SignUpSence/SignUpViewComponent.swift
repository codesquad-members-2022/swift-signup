//
//  SignUpView.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewComponent:UIView {
    
    private lazy var label = UILabel()
    private lazy var textField:UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    private func setUp() {
        [label,textField].forEach{ self.addSubview($0) }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
    }
    
    func labelText(text:String) {
        self.label.text = text
    }
    
    func placeholder(text:String) {
        self.textField.placeholder = text
    }
    
}

