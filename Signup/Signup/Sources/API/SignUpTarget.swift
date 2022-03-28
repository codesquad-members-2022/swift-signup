//
//  SignUp.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation

enum SignUpTarget: BaseTarget {
    case signUp(userId: String, password: String)
}

extension SignUpTarget {
    var path: String {
        switch self {
        case .signUp:
            return "/signup"
        }
    }
    
    var parameter: [String:Any]? {
        switch self {
        case .signUp(let userId, let password):
            return [
                "id":userId,
                "password":password
            ]
        }
    }
    
    var method: String {
        switch self {
        case .signUp:
            return "POST"
        }
    }
}
