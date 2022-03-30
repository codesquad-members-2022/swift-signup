//
//  ValidationRegularTextFactory.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

//import Foundation
//class ValidationRegularTextFactory {
//
//    static func makeRegularExpression(as validType: ValidationRegularText.ValidType) -> ValidationRegularText? {
//
//        var pattern = ""
//
//        switch validType {
//        case .id:
//            return ValidationRegularText(pattern: "none", follow: .caseInsensitive, as: .id)
//        case .password:
//            return ValidationRegularText(pattern: "none", follow: .caseInsensitive, as: .password)
//        case .emailAddress:
//            return ValidationRegularText(pattern: "none", follow: .caseInsensitive, as: .emailAddress)
//        case .phoneNumber:
//            return ValidationRegularText(pattern: "none", follow: .caseInsensitive, as: .phoneNumber)
//        }
//
//        return ValidationRegularText(pattern: "none", follow: .caseInsensitive, as: .phoneNumber)
//    }
//
//
//}
