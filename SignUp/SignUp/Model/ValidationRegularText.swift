//
//  ValidationRegularText.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class ValidationRegularText: NSRegularExpression {
    
    // MARK: - Local properties
    
    private var validType: ValidType = ValidType.id
    private var commentGenerator: CommentGenerator?
    
    private(set) var comment: ValidationComment?
    
    // MARK: - Initializers
    
    convenience init(pattern: String, options: NSRegularExpression.Options = [], as type: ValidType, using generator: CommentGenerator? = nil) throws {
        try self.init(pattern: pattern, options: options)
        self.commentGenerator = generator
        self.validType = type
    }
    
    override init(pattern: String, options: NSRegularExpression.Options = []) throws {
        try super.init(pattern: pattern, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - matching methods
    
    override func matches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: NSRange) -> [NSTextCheckingResult] {
        let result = super.matches(in: string, options: options, range: range)
        self.comment = commentGenerator?.convertComment(in: string, with: result)
        return result
    }

    override func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], range: NSRange) -> Int {
        let result = super.numberOfMatches(in: string, options: options, range: range)
        self.comment = commentGenerator?.convertComment(in: string, with: result)
        return result
    }

    override func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [], range: NSRange) -> NSRange {
        let result = super.rangeOfFirstMatch(in: string, options: options, range: range)
        self.comment = commentGenerator?.convertComment(in: string, with: result)
        return result
    }

    override func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [], range: NSRange) -> NSTextCheckingResult? {
        let result = super.firstMatch(in: string, options: options, range: range)
        self.comment = commentGenerator?.convertComment(in: string, with: result)
        return result
    }
    
    // MARK: - Validation Types
    
    enum ValidType {
        case id
        case password
        case birthDay
        case emailAddress
        case phoneNumber
        case favoriteCategory
    }
}
