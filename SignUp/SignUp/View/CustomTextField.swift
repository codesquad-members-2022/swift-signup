//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit


class CustomTextField: UITextField {
    
    private var currentState = ValidationRegularText.ValidType.id
    private var commentView: CommentUnderTheView?
    
    func setValidationType(_ type: ValidationRegularText.ValidType) {
        self.currentState = type
        let validator = ValidationRegularTextFactory.makeRegularExpression(as: currentState)
        
        // TODO: Instance will be immediately deallocated because property 'delegate' is 'weak'
        self.delegate = CustomTextFieldDelegate(validation: validator)
    }
    
    func setCommentView(as resultType: CommentUnderTheView.State) {
        
    }
    
    convenience init?(in frame: CGRect, type validType: ValidationRegularText.ValidType, messageHandler: ([CommentUnderTheView.State])->Dictionary<CommentUnderTheView.State, String>) {
        self.init(frame: frame)
        self.currentState = validType
        setValidationType(validType)
        self.commentView = CommentUnderTheView(with: self.frame, messageHandler: messageHandler)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
