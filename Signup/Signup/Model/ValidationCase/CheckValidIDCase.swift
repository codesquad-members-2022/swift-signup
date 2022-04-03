//
//  CheckValidIDCase.swift
//  Signup
//
//  Created by juntaek.oh on 2022/03/30.
//

import Foundation

enum CheckValidIDCase: String{
    case shortLength = "아이디가 너무 짧습니다"
    case longLength = "아이디가 너무 깁니다"
    case invalid = "유효하지 않은 아이디입니다"
    case valid = "유효한 아이디입니다"
    case usedId = "이미 존재하는 아이디입니다"
    
    func showReason() -> String{
        return self.rawValue
    }
}
