//
//  TextFieldManger.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

import Foundation

final class SignUpTextFieldManger:SignUpInputViewTextFieldMangerable{
    
    var checker:RegularExpressionCheckable?
    
    init(checker:RegularExpressionCheckable?) {
        self.checker = checker
    }
    
    func transFormResultToText(checkedResult:TextFieldInputResult) -> (String,RGB) {
        switch checkedResult {
        case .idResult(result: .success):
            return ("사용 가능한 아이디입니다.",RGB.green)
        case .idResult(result: .failure(type: .alreadyExisted)):
            return ("이미 사용중인 아이디입니다.",RGB.red)
        case .idResult(result: .failure(type: .notValidateForm)):
            return ("5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다. ",RGB.red)

        case .passwordResult(result: .success):
            return ("안전한 비밀번호입니다.",RGB.green)
        case .passwordResult(result: .failure(type: .upperRegex)):
            return ("영문 대문자를 최소 1자 이상 포함해주세요.",RGB.red)
        case .passwordResult(result: .failure(type: .lengthRegexs)):
            return ("8자 이상 16자 이하로 입력해주세요.",RGB.red)
        case .passwordResult(result: .failure(type: .lowerRegex)):
            return ("영문 소문자를 최소 1자 이상 포함해주세요.",RGB.red)
        case .passwordResult(result: .failure(type: .numberRegexs)):
            return ("숫자를 최소 1자 이상 포함해주세요.",RGB.red)
        case .passwordResult(result: .failure(type: .specialCharacterRegexs)):
            return ("특수문자를 최소 1자 이상 포함해주세요.",RGB.red)

        default:
                return ("",RGB(red: 0, green: 0, blue: 0))
        }
    }
    
    func validateText(signUpInputView: SignUpInputViewable)  {
        guard let inputView = signUpInputView as? SignUpInputView,
              let text = inputView.getTextFieldText(),
              let checker = checker else { return }
        //result = inputView & result
        let result:(result:TextFieldInputResult,inputView:SignUpInputView) = (checker.check(expression:text),inputView)
        
        NotificationCenter.default.post(
            name: SignUpTextFieldManger.NotificationName.checkedTextField,
            object: self,
            userInfo: [SignUpTextFieldManger.UserInfoKey.checkedValidation:result]
        )
    }
    
    enum UserInfoKey {
        case checkedValidation
    }
    
    
    struct NotificationName {
        static let checkedTextField = Notification.Name("checkedTextField")

    }
}




