//
//  PasswordVaildate.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

class PasswordVaildate: BaseValidate {
    static func verification(text: String) -> ValidateResultType {
        if text.isEmpty {
            return .none
        }
        
        if validatePredicate(text, format: ".{8,16}") == false {
            return .errorLengthLimited
        }
        
        if vaildateRegex(text, pattern: "[A-Z]") == false {
            return .errorNoCapitalLetters
        }
        
        if vaildateRegex(text, pattern: "[0-9]") == false {
            return .errorNoNumber
        }
        
        if vaildateRegex(text, pattern: "[!@#$%^&*()_+=-]") == false {
            return .errorNoSpecialCharacters
        }
        return .success
    }
}
