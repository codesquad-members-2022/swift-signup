//
//  CheckValidationNameCase.swift
//  Signup
//
//  Created by juntaek.oh on 2022/04/03.
//

import Foundation

enum CheckValidNameCase: String{
    case invalid = "이름은 필수 입력입니다"
    case valid = ""
    
    func showReason() -> String{
        return self.rawValue
    }
}
