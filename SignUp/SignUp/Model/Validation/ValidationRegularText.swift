//
//  ValidationRegularText.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class ValidationRegularText: ValidationCommons {
    
    // MARK: - Local properties
    
    private var regularExpression: NSRegularExpression
    
    // MARK: - Initializers
    
    init?(as type: ValidType, follow options: NSRegularExpression.Options = []) {
        do {
            regularExpression = try NSRegularExpression(pattern: type.rawValue, options: options)
        } catch {
            return nil
        }
        
        super.init(in: type)
    }
    
    // MARK: - matching methods
    
//    func validateResult(in string: String) {
//        guard string.count > 0 else { return }
//        let results = regularExpression.matches(in: string, range: NSMakeRange(0, string.count))
//        validationResult.validateResultState(in: string, using: results)
//    }
    override func validate(using string: String) {
        super.validate(using: string)
        let results = regularExpression.matches(in: string, range: NSMakeRange(0, string.count))
        validationResult?.validateResultState(in: string, using: results)
    }
}
