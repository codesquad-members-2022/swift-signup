//
//  InputComponentsView.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import UIKit

class InputComponentsView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .white
        textField.addLeftPadding()
        return textField
    }()
    
    init(frame: CGRect, title: String, placeholder: String = "") {
        super.init(frame: frame)
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.titleLabel.text = ""
        self.textField.placeholder = ""
        setLayout()
    }
    
    private func setLayout() {
        let space: CGFloat = 5.0
        let height: CGFloat = 35.0
        
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: space).isActive = true
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

extension UITextField {
    fileprivate func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
