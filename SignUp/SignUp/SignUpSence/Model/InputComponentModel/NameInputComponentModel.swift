//
//  NameInputComponentModel.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

struct NameInputComponentModel:InputComponentable {
    var checker: RegularExpressionCheckable? = nil
    var id: inputViewIdentifierable = NameViewIdentifier()
    var labelText: String = "이름"
    var placeHolder: String = ""
}
