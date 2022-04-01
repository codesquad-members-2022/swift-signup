//
//  TextFieldMangerable.swift
//  SignUp
//
//  Created by 박진섭 on 2022/04/01.
//

protocol SignUpInputViewTextFieldMangerable {
    var checker:RegularExpressionCheckable? { get }
    func validateText(signUpInputView: SignUpInputViewable) -> TextFieldInputResult
    func check(checkedText:TextFieldInputResult) -> String
}
