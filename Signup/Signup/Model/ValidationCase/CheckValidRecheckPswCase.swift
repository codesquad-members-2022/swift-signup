//
//  CheckValidation.swift
//  Signup
//
//  Created by juntaek.oh on 2022/04/01.
//

import Foundation

enum CheckValidRecheckPswCase: String{
    case invalid = "비밀번호 일치하지 않습니다"
    case valid = "비밀번호가 일치합니다"
    
    func showReason() -> String{
        return self.rawValue
    }
}
