//
//  TextFieldMangerFactory.swift
//  SignUp
//
//  Created by 박진섭 on 2022/04/01.
//

final class TextFieldMangerFactory:TextFieldMangerCreator {
    func makeTextFieldManger(id: inputViewIdentifierable) -> SignUpInputViewTextFieldMangerable {
        switch id.id {
        case "ID":
            return SignUpTextFieldManger(checker: IDExpressionChecker())
        case "password":
            return SignUpTextFieldManger(checker: PasswordExpressionChecker())
        default:
            return SignUpTextFieldManger(checker: nil)
        }
    }
}
