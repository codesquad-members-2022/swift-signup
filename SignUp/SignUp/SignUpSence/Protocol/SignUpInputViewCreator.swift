//
//  SignUpInputViewCreator.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

protocol SignUpInputViewCreator {
    func makeSignUpViewComponent(inputModel:InputComponentable) -> SignUpInputViewable
}
