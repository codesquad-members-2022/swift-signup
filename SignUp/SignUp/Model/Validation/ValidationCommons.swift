//
//  ValidationCommons.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/31.
//

import Foundation

/// SignUp 앱의 검증 관련 추상화 클래스
///
/// - validType : 검증할 데이터의 종류입니다.
/// - validateResult:  검증할 string 변수가 0 이상이라면 실행될 수 있도록 하는 함수입니다.
class ValidationCommons {
    private var validType: ValidType?
    private(set) var validationResult: ValidationResult?
    
    init(in type: ValidType) {
        // ValidType이 몇개 되지는 않지만 나중에 많아질 것을 대비해 여기도 팩토리 클래스를 적용해 보았습니다.
        validationResult = ValidationResultFactory.makeResult(in: type)
    }
    
    func validate(using string: String) {
        guard string.count > 0 else { return }
    }
    
    // MARK: - Validation Types
    
    enum ValidType: String {
        case id = "^[a-z0-9-_]{1,}$"
        case password = "^[A-Z0-9!@#$%^&*()]{1,}"
        case passwordConfirm = "passwordConfirm"
        case emailAddress = "^[a-zA-Z0-9_-]{1,}@[a-zA-Z0-9_-]{1,}(.)[(com)(net)(or.kr)]{1}$"
        case phoneNumber = "^01[0-9]{1}-[0-9]{4}-[0-9]{4}$"
    }
}
