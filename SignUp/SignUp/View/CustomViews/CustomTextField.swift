//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

final class CustomTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    private(set) lazy var commentLabel = CustomCommentLabel(frame: self.frame)
    var validator: ValidationRegularText?
    
    // MARK: - Initialzers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        addSubview(commentLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        addSubview(commentLabel)
    }
}
