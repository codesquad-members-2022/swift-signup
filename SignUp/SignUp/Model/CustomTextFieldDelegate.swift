//
//  CustomTextFieldDelegate.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var validation: ValidationRegularText?
    
    convenience init(validation: ValidationRegularText?) {
        self.init()
        self.validation = validation
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - 정규식을 이용한 텍스트 검증
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let targetString = textField.text, let validation = validation else { return }
        let matches = validation.matches(in: targetString, range: NSMakeRange(0, targetString.count))
        
        // 임시로 구현. 일치하는 부분이 존재하면 correct 상태를 전달하도록 하였습니다.
        let type: CommentUnderTheView.State = matches.count > 0 ? .correct : .warning
        
        (textField as? CustomTextField)?.setCommentView(as: type)
    }
}
