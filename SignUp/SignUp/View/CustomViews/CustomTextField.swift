//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

/// CustomTextField에서 validator를 실행하기위한 Delegate입니다.
protocol ValidationDelegate {
    func didValidate(in string: String)
    func didEndValidate()
}

class CustomTextField: UITextField {
    
    // MARK: - Local Properties
    
    /// idTextField의 delegate 프로퍼티는 weak이기 때문에 init, viewDidLoad등 초기화 함수가 끝나면 nil 처리가 될 수 있습니다. 내부 프로퍼티로 선언해두고, 텍스트필드와 라이프사이클을 같이 하도록 하였습니다.
    private lazy var customDelegate = CustomTextFieldDelegate(delegate: self)
    
    private(set) lazy var commentLabel = CustomCommentLabel(frame: self.frame)
    
    var validator: ValidationCommons?
    var validResult: ValidationResult? {
        validator?.validationResult
    }
    
    // MARK: - Initialzers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(commentLabel)
        delegate = customDelegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(commentLabel)
        delegate = customDelegate
    }
}

extension CustomTextField: ValidationDelegate {
    func didValidate(in string: String) {
        validator?.validate(using: string)
        if let result = validator?.validationResult {
            commentLabel.showComment(in: string, following: result)
        }
    }
    
    func didEndValidate() {
        if validResult?.state == .good {
            commentLabel.hideComment()
        }
    }
}
