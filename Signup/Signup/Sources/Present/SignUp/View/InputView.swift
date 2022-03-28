//
//  InputView.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import UIKit

class InputView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout() {
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.addSubview(textField)
        textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.addSubview(errorLabel)
        errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.bottomAnchor.constraint(equalTo: errorLabel.bottomAnchor).isActive = true
    }
}
