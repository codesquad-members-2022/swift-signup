//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

protocol ValidationDelegate {
//    func willValidate(in string: String)
    func didValidate(in string: String)
}

class CustomTextField: UITextField {
    
    // MARK: - Property Overrided
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }
    
    // MARK: - Local Properties
    
    private(set) lazy var commentLabel = CustomCommentLabel(frame: self.frame)
    var validator: ValidationRegularText?
    
    // MARK: - Initialzers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(commentLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(commentLabel)
    }
}

extension CustomTextField: ValidationDelegate {
//    func willValidate(in string: String) {
//        validator?.validateResult(in: string)
//    }
    
    func didValidate(in string: String) {
        validator?.validateResult(in: string)
        if let validation = validator?.validationResult {
            commentLabel.showComment(in: string, following: validation)
        } else {
            commentLabel.hideComment()
        }
    }
}
