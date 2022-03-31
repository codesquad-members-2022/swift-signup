//
//  UserIdVelidate.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

class UserIdVelidate: BaseValidate {
    static func verification(text: String) -> ValidateResultType {
        if text.isEmpty {
            return .none
        }
        if validatePredicate(text, format: "[A-Za-z0-9_-]{5,20}") {
            return .success
        } else { return .errorUserId }
    }
}
