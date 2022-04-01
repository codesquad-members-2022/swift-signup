//
//  ValidationResultFactory.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/30.
//

import Foundation

class ValidationResultFactory {
    static func makeResult(in type: ValidationRegularText.ValidType) -> ValidationResult {
        switch type {
        case .id:
            return IDValidationResult()
        case .password:
            return PasswordValidationResult()
        case .passwordConfirm:
            return PasswordConfirmValidationResult()
        case .emailAddress:
            return EmailValidationResult()
        case .phoneNumber:
            return PhoneNumberValidationResult()
        }
    }
}
