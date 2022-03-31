//
//  TextFieldInputResult.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

import Foundation

enum TextFieldInputResult {
    
    enum IDResult{
        case success
        case failure
    }

    enum PasswordResult {
        case noValidateLength
        case noUpperCharacter
        case noNumber
        case noSpecialCharacter
    }
}


