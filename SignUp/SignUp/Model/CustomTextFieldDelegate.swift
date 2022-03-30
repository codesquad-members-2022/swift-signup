//
//  CustomTextFieldDelegate.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/29.
//

import Foundation
import UIKit

class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    private var commentLabelIn: (UITextField) -> CustomCommentLabel? = { textField in
        (textField as? CustomTextField)?.commentLabel
    }
    
    private var validatorIn: (UITextField) -> ValidationRegularText? = { textField in
        (textField as? CustomTextField)?.validator
    }
    
    // MARK: - Methods Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        commentLabelIn(textField)?.hideComment()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text else { return }
        
        guard targetString.count == 0 else {
            commentLabelIn(textField)?.hideComment()
            return
        }
        
        let _ = validatorIn(textField)?.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        commentLabelIn(textField)?.showComment(validatorIn(textField)?.comment)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let targetString = textField.text else { return false }
        let _ = validatorIn(textField)?.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        commentLabelIn(textField)?.showComment(validatorIn(textField)?.comment)
        
        return true
    }
}
