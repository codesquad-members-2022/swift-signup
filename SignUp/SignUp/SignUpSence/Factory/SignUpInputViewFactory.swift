//
//  SignUpInputViewFactory.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

final class SignUpInputViewFactory:SignUpInputViewCreator {
    func makeSignUpViewComponent(inputModel:InputComponentable) -> SignUpInputViewable {
        let viewComponent = SignUpInputView(frame: .zero)
        viewComponent.labelText(text: inputModel.labelText)
        viewComponent.placeholder(text: inputModel.placeHolder)
        viewComponent.setIdentifier(id:inputModel.id)
        return viewComponent
    }
}
