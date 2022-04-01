//
//  TextFieldInputResult.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

import Foundation

enum TextFieldInputResult {

    case idResult(result:TextFieldInputResult.IDResult)
    case passwordResult(result:TextFieldInputResult.PasswordResult)
    case unknown
    
    enum IDResult{
        case success
        case failure(type:IDError)
    }

    enum PasswordResult {
        case success
        case failure(type:PasswordRegex)
    }
}


