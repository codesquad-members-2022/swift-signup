//
//  CustomTextField.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit


class CustomTextField: UITextField {
    
    // MARK: - Local Properties
    
    private var currentState = ValidationRegularText.ValidType.id
    private var commentView: CustomTextFieldCommentLabel?
    
    // MARK: - Initialzers
    
    convenience init?(in frame: CGRect, type validType: ValidationRegularText.ValidType, messageHandler: ([CustomTextFieldTextState])->Dictionary<CustomTextFieldTextState, String>) {
        self.init(frame: frame)
        self.currentState = validType
        setValidationType(validType)
        self.commentView = CustomTextFieldCommentLabel(with: self.frame, messageHandler: messageHandler)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Utilities
    
    func setValidationType(_ type: ValidationRegularText.ValidType) {
        self.currentState = type
        let validator = ValidationRegularTextFactory.makeRegularExpression(as: currentState)
        
        // TODO: Instance will be immediately deallocated because property 'delegate' is 'weak'
        self.delegate = CustomTextFieldDelegate(validation: validator)
    }
    
    func setCommentView(as resultType: CustomTextFieldCommentLabel.State) {
        commentView?.showComment(state: resultType)
    }
    
    func hideCommentView() {
        commentView?.hideComment()
    }
}
