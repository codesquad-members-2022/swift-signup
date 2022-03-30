//
//  ValidationRegularText.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class ValidationRegularText {
    
    // MARK: - Local properties
    
    private var validType: ValidType = ValidType.id
    private(set) var validationResult: ValidationResult
    
    private var regularExpression: NSRegularExpression
    
    // MARK: - Initializers
    
    init?(as type: ValidType, follow options: NSRegularExpression.Options = []) {
        do {
            regularExpression = try NSRegularExpression(pattern: type.rawValue, options: options)
            // ValidType이 몇개 되지는 않지만 나중에 많아질 것을 대비해 여기도 팩토리 클래스를 적용해 보았습니다.
            validationResult = ValidationResultFactory.makeResult(in: validType)
        } catch {
            return nil
        }
    }
    
    // MARK: - matching methods
    
    func validateResult(in string: String) {
        guard string.count > 0 else { return }
        let results = regularExpression.matches(in: string, range: NSMakeRange(0, string.count))
        validationResult.validateResultState(in: string, using: results)
    }
    
    // MARK: - Validation Types
    
    enum ValidType: String { // ValidationRegularText
        case id = "^[a-z0-9-_]{1,}$"
        case password = "^[A-za-z0-9!@#$%^&*()]{1,}"
        case emailAddress = "^[a-zA-Z0-9_-]{1,}@[a-zA-Z0-9_-]{1,}(.)[(com)(net)(or.kr)]{1}$"
        case phoneNumber = "^01[0-9]{1}-[0-9]{4}-[0-9]{4}$"
    }
}
