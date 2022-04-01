//
//  CheckValidPsw.swift
//  Signup
//
//  Created by juntaek.oh on 2022/04/01.
//

import Foundation

enum CheckValidPswCase: String{
    case shortLegth = "비밀번호가 너무 짧습니다"
    case longLength = "비밀번호가 너무 깁니다"
    case noUpperCase = "대문자가 포함되지 않았습니다"
    case noNumber = "숫자가 포함되지 않았습니다"
    case noSpecialChar = "특수문자가 포함되지 않거나 올바르지 않습니다"
    case invalid = "유효하지 않은 비밀번호입니다"
    case valid = "유효한 비밀번호입니다"
    
    func showReason() -> String{
        return self.rawValue
    }
}
