//
//  CustomTextFieldDelegate.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Local Property
    
    private var validation: ValidationRegularText?
    
    // MARK: - Initializer
    
    convenience init(validation: ValidationRegularText?) {
        self.init()
        self.validation = validation
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - 정규식을 이용한 텍스트 검증
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (textField as? CustomTextField)?.hideCommentView()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text, let validation = validation else { return }
        let _ = validation.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        (textField as? CustomTextField)?.resolveComment()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let targetString = textField.text, let validation = validation else { return false }
        let _ = validation.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        (textField as? CustomTextField)?.resolveComment()
        
        return true
    }
}
