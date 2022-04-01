//
//  InputComponentModel.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//


struct IDInputComponentModel:InputComponentable {
    var checker: RegularExpressionCheckable? = IDExpressionChecker()
    var id: inputViewIdentifierable = IDViewIdentifier()
    var labelText: String = "아이디"
    var placeHolder: String = "영문 대/소문자, 숫자, 특수기호(_,-) 5~20자"
}
