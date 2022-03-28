//
//  SignUpInputViewCreator.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

protocol SignUpInputViewCreator {
    static func makeSignUpViewComponent(labelText:String, placeHolder:String) -> SignUpInputViewable
}
