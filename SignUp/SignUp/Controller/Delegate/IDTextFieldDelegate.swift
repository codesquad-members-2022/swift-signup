//
//  IDTextFieldDelegate.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/30.
//

import Foundation
import UIKit

class IDTextFieldDelegate: NSObject, UITextFieldDelegate {
    enum NotificationNames {
        static let didGetSuccessValidation = Notification.Name("IDTextFieldDelegateDidSuccessValidate")
        static let didGetLackOfLettersError = Notification.Name("IDTextFieldDelegateDidGetLackOfLettersError")
        static let didGetMuchOfLettersError = Notification.Name("IDTextFieldDelegateDidGetMuchOfLettersError")
        static let didGetInvalidSymbolError = Notification.Name("IDTextFieldDelegateDidGetInvalidSymbolError")
        static let didGetUnknownError = Notification.Name("IDTextFieldDelegateDidGetUnknownError")
    }
    
    let validator: Validatable
    
    init(with validator: Validatable) {
        self.validator = validator
        super.init()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let validationResult = validator.validate(of: textField.text ?? "")
        
        switch validationResult {
            case .success(true):
                NotificationCenter.default.post(name: IDTextFieldDelegate.NotificationNames.didGetSuccessValidation, object: self)
            case .failure(IDValidateError.lackOfLetter):
                NotificationCenter.default.post(name: IDTextFieldDelegate.NotificationNames.didGetLackOfLettersError, object: self)
            case .failure(IDValidateError.muchOfLetter):
                NotificationCenter.default.post(name: IDTextFieldDelegate.NotificationNames.didGetMuchOfLettersError, object: self)
            case .failure(IDValidateError.invalidSymbol):
                NotificationCenter.default.post(name: IDTextFieldDelegate.NotificationNames.didGetInvalidSymbolError, object: self)
            default:
                NotificationCenter.default.post(name: IDTextFieldDelegate.NotificationNames.didGetUnknownError, object: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
