//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

final class CustomTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    private lazy var commentLabel = CustomCommentLabel(frame: self.frame)
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

    // MARK: - Methods in delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        commentLabel.hideComment()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text else { return }
        
        guard targetString.count == 0 else {
            commentLabel.hideComment()
            return
        }
        let _ = validator?.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        commentLabel.showComment(validator?.comment)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let targetString = textField.text else { return false }
        let _ = validator?.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        commentLabel.showComment(validator?.comment)
        
        return true
    }
}
