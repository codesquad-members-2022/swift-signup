//
//  SignUpViewFactory.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//


final class SignUpViewFactory:SignUpViewCreator {
    static func makeSignUpViewComponent(labelText: String, placeHolder: String) -> SignUpViewComponent {
        let viewComponent = SignUpViewComponent(frame: .zero)
        viewComponent.labelText(text: labelText)
        viewComponent.placeholder(text: placeHolder)
        return viewComponent
    }
}
