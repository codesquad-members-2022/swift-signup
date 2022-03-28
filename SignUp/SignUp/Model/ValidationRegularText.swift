//
//  ValidationRegularText.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class ValidationRegularText: NSRegularExpression {
    
    private var validType: ValidType = ValidType.id
    
    convenience init(pattern: String, options: NSRegularExpression.Options = [], as type: ValidType) throws {
        try self.init(pattern: pattern, options: options)
        self.validType = type
    }
    
    override init(pattern: String, options: NSRegularExpression.Options = []) throws {
        try super.init(pattern: pattern, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    enum ValidType {
        case id
        case password
        case birthDay
        case emailAddress
        case phoneNumber
        case favoriteCategory
    }
}
