//
//  CustomTextFieldDelegate.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/29.
//

import Foundation
import UIKit

/// UITextFieldDelegate 중 이벤트 관련 메소드 실행 후 ValidationDelegate의 메소드를 실행하도록 하는 커스텀 Delegate 입니다.
///
/// 즉, 이 델리게이트를 사용할 CustomTextField는 ValidationDelegate를 구현하고 있어야 합니다.
class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Local Properties
    
    var validationDelegate: ValidationDelegate?
    
    convenience init(delegate: ValidationDelegate) {
        self.init()
        self.validationDelegate = delegate
    }
    
    // MARK: - Methods Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let targetText = textField.text else { return false }
        validationDelegate?.didValidate(in: targetText)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validationDelegate?.didEndValidate()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var targetText = textField.text else { return false }
        if targetText.count > range.location {
            targetText.removeSubrange(
                targetText.index(targetText.startIndex, offsetBy: range.location)..<targetText.index(targetText.startIndex, offsetBy: range.location+range.length)
            )
            validationDelegate?.didValidate(in: targetText)
        } else {
            validationDelegate?.didValidate(in: targetText+string)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard let targetText = textField.text else { return false }
        validationDelegate?.didValidate(in: targetText)
        return true
    }
}
