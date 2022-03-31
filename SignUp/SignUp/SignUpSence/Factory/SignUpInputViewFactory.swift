//
//  SignUpInputViewFactory.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

final class SignUpInputViewFactory:SignUpInputViewCreator {
    func makeSignUpViewComponent(id:String, labelText: String, placeHolder: String) -> SignUpInputViewable {
        let viewComponent = SignUpInputView(frame: .zero)
        viewComponent.labelText(text: labelText)
        viewComponent.placeholder(text: placeHolder)
        viewComponent.setIdentifier(id: id)
        return viewComponent
    }
}
