//
//  SignUpViewModel.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

class SignUpModel {
        
    struct Action {
        let enteredUserId = CurrentValueSubject<String, Never>("")
        let enteredPassword = CurrentValueSubject<String, Never>("")
        let enteredCheckPassword = PassthroughSubject<String, Never>()
        let enteredUserName = PassthroughSubject<String, Never>()
        let tappedNextButton = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let userIdMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let passwordMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let checkPasswordMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let userNameMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        
        let isEnabledNextButton = PassthroughSubject<Bool, Never>()
        let presentNextPage = PassthroughSubject<Void, Never>()
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    let signUpRespository: SignUpRepository = SignUpRepositoryImpl()
    
    init() {
        Publishers
            .Merge4(
                state.userIdMessage.map { _ in },
                state.passwordMessage.map { _ in },
                state.checkPasswordMessage.map { _ in },
                state.userNameMessage.map { _ in })
            .map {
                if self.state.userIdMessage.value.0,
                   self.state.passwordMessage.value.0,
                   self.state.checkPasswordMessage.value.0,
                   self.state.userNameMessage.value.0 {
                    return true
                }
                return false
            }
            .sink(receiveValue: self.state.isEnabledNextButton.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserId
            .map {
                if $0.isEmpty {
                    return (false ,"")
                }
                if $0.validatePredicate(format: "[A-Za-z0-9_-]{5,20}") {
                    return (true, "사용 가능한 아이디입니다.")
                } else {
                    return (false, "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다.")
                }
            }
            .sink(receiveValue: self.state.userIdMessage.send(_:))
            .store(in: &cancellables)
        
        action.enteredPassword
            .map {
                if $0.isEmpty {
                    return (false ,"")
                }
                
                if $0.validatePredicate(format: ".{8,16}") == false {
                    return (false, "8자 이상 16자 이하로 입력해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[A-Z]") == false {
                    return (false, "영문 대문자를 최소 1자 이상 포함해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[0-9]") == false {
                    return (false, "숫자를 최소 1자 이상 포함해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[!@#$%^&*()_+=-]") == false {
                    return (false, "특수문자를 최소 1자 이상 포함해주세요.")
                }
                
                return (true, "안전한 비밀번호입니다.")
            }
            .sink(receiveValue: self.state.passwordMessage.send(_:))
            .store(in: &cancellables)
        
        action.enteredCheckPassword
            .combineLatest(action.enteredPassword)
            .map {
                if $0 != $1 {
                    return (false, "비밀번호가 일치하지 않습니다.")
                } else {
                    return (true, "비밀번호가 일치합니다.")
                }
            }
            .sink(receiveValue: self.state.checkPasswordMessage.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserName
            .map {
                if $0.isEmpty {
                    return (false , "이름은 필수 입력 항목입니다.")
                } else {
                    return (true , "비밀번호가 일치합니다.")
                }
            }
            .sink(receiveValue: self.state.userNameMessage.send(_:))
            .store(in: &cancellables)
        
        self.action.tappedNextButton
            .map { _ -> AnyPublisher<Response<ResponseResult>, Error> in
                let userId = self.action.enteredUserId.value
                let password = self.action.enteredPassword.value
                return self.signUpRespository.signUp(userId: userId, password: password)
            }
            .sink(receiveCompletion: { data in
                //TODO: 회원가입 실패 시 처리
            }, receiveValue: { data in
                self.state.presentNextPage.send()
            }).store(in: &cancellables)
    }
}
