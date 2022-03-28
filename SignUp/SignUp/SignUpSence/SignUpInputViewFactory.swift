//
//  SignUpInputViewFactory.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

final class SignUpInputViewFactory:SignUpInputViewCreator {
    func makeSignUpViewComponent(labelText: String, placeHolder: String) -> SignUpInputViewable {
        let viewComponent = SignUpInputViewComponent(frame: .zero)
        viewComponent.labelText(text: labelText)
        viewComponent.placeholder(text: placeHolder)
        return viewComponent
    }
}
