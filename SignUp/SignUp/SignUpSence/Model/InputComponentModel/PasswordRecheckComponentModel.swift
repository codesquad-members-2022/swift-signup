//
//  PasswordRecheckComponentModel.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

struct PasswordRecheckInputComponentModel:InputComponentable {
    var checker: RegularExpressionCheckable? = PasswordExpressionChecker()
    var id:inputViewIdentifierable = PasswordViewIdentifier()
    var labelText: String = "비밀번호 재확인"
    var placeHolder: String = ""
}

