//
//  ValidateTextFieldDelegate.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/29.
//

import Foundation
import UIKit

class ValidateTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    var validationDelegate: ValidationDelegate?
    
    convenience init(delegate: ValidationDelegate) {
        self.init()
        self.validationDelegate = delegate
    }
    
    // MARK: - Methods Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let targetString = textField.text else { return false }
        validationDelegate?.didValidate(in: targetString)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text else { return }
        validationDelegate?.didValidate(in: targetString)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let targetString = textField.text else { return false }
        validationDelegate?.didValidate(in: targetString+string)
        return true
    }
}
