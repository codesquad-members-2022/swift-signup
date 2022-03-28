//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit


class CustomTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    private lazy var commentView = CustomCommentLabel(frame: self.frame )
    var validator: ValidationRegularText?
    
    // MARK: - Initialzers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        addSubview(commentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        addSubview(commentView)
    }

    // MARK: - Utilities
    
    func resolveComment() {
        commentView.showComment(validator?.comment)
    }
    
    func hideCommentView() {
        commentView.hideComment()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (textField as? CustomTextField)?.hideCommentView()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text, let validator = validator else { return }
        let _ = validator.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        resolveComment()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let targetString = textField.text else { return false }
        let _ = validator?.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        resolveComment()
        
        return true
    }
}
