//
//  SignUpViewCreator.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

protocol SignUpViewCreator {
    static func makeSignUpViewComponent(labelText:String, placeHolder:String) -> SignUpViewComponent
}
