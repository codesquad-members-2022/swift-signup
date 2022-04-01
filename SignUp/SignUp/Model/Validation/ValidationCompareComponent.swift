//
//  ValidationCompareComponent.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/31.
//

import Foundation

class ValidationCompareComponent: ValidationCommons {
    
    private var comparableTextField: CustomTextField?
    private var compareHandler: ((Bool)->Void)!
    
    init(comparable textField: CustomTextField, compareHandler: @escaping (Bool)->Void) {
        super.init(in: .passwordConfirm)
        self.comparableTextField = textField
        self.compareHandler = compareHandler
    }
    
    override func validate(using string: String) {
        super.validate(using: string)
        
        if comparableTextField?.validResult?.state == .good {
            (validationResult as? PasswordConfirmValidationResult)?.compareValidate(in: string, compare: (comparableTextField?.text ?? ""))
            compareHandler(true)
            return
        }
        
        compareHandler(false)
    }
}
