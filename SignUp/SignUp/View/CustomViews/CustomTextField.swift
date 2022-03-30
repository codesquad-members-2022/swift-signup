//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

protocol ValidationDelegate {
    func didValidate(in string: String)
    func didEndValidate()
}

class CustomTextField: UITextField {
    
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
    func didValidate(in string: String) {
        validator?.validateResult(in: string)
        if let validation = validator?.validationResult {
            commentLabel.showComment(in: string, following: validation)
        }
    }
    
    func didEndValidate() {
        if validator?.validationResult.state == .good {
            commentLabel.hideComment()
        }
    }
}
