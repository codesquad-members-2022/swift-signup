//
//  PasswordInputComponentModel.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

struct PasswordInputComponentModel:InputComponentable {
    var checker: RegularExpressionCheckable? = PasswordExpressionChecker()
    var id: inputViewIdentifierable = PasswordViewIdentifier()
    var labelText: String = "비밀번호"
    var placeHolder: String = "영문 대/소문자, 숫자, 특수문자(!@#$% 8~16자"
}

