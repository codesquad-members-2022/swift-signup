//
//  SignUpViewModel.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import Foundation
import Combine

class SignUpModel {
    
    enum MessageType {
        case none, error, success
    }
    
    struct Action {
        let userIdEntered = CurrentValueSubject<String, Never>("")
        let passwordEntered = CurrentValueSubject<String, Never>("")
        let checkPasswordEntered = PassthroughSubject<String, Never>()
        let userNameEntered = PassthroughSubject<String, Never>()
        let nextButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let userIdMessage = PassthroughSubject<(MessageType, String), Never>()
        let passwordMessage = PassthroughSubject<(MessageType, String), Never>()
        let checkPasswordMessage = PassthroughSubject<(MessageType, String), Never>()
        let userNameMessage = PassthroughSubject<(MessageType, String), Never>()
        let isNextButtonEnabled = PassthroughSubject<Bool, Never>()
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    let signUpRespository: SignUpRepository = SignUpRepositoryImpl()
    
    init() {
        Publishers
            .Merge4(action.userIdEntered, action.passwordEntered, action.checkPasswordEntered, action.userNameEntered)
            .combineLatest(state.userIdMessage, state.userNameMessage)
            .map { _, userId, userName in
                (userId.0, userName.0)
            }
            .combineLatest(state.passwordMessage, state.checkPasswordMessage)
            .map { user, password, checkPassword in
                (user, (password.0, checkPassword.0))
            }
            .sink { user, password in
                if user.0 == .success,
                   user.1 == .success,
                   password.0 == .success,
                   password.1 == .success {
                    self.state.isNextButtonEnabled.send(true)
                } else {
                    self.state.isNextButtonEnabled.send(false)
                }
            }.store(in: &cancellables)
        
        action.userIdEntered
            .sink {
                if $0.isEmpty {
                    self.state.userIdMessage.send((.none, ""))
                    return
                }
                
                if $0.validatePredicate(format: "[A-Za-z0-9_-]{5,20}") {
                    self.state.userIdMessage.send((.success, "사용 가능한 아이디입니다."))
                } else {
                    self.state.userIdMessage.send((.error, "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."))
                }
            }.store(in: &cancellables)
        
        action.passwordEntered
            .sink {
                if $0.isEmpty {
                    self.state.passwordMessage.send((.none, ""))
                    return
                }
                if $0.count < 8 || $0.count > 16 {
                    self.state.passwordMessage.send((.error, "8자 이상 16자 이하로 입력해주세요."))
                    return
                }
                
                if $0.vaildateRegex(pattern: "[A-Z]") == false {
                    self.state.passwordMessage.send((.error, "영문 대문자를 최소 1자 이상 포함해주세요."))
                    return
                }
                
                if $0.vaildateRegex(pattern: "[0-9]") == false {
                    self.state.passwordMessage.send((.error, "숫자를 최소 1자 이상 포함해주세요."))
                    return
                }
                
                if $0.vaildateRegex(pattern: "[~!@#$%^&*()_+-=?]") == false {
                    self.state.passwordMessage.send((.error, "특수문자를 최소 1자 이상 포함해주세요."))
                    return
                }
                
                self.state.passwordMessage.send((.success, "안전한 비밀번호입니다."))
            }.store(in: &cancellables)
        
        action.checkPasswordEntered
            .combineLatest(action.passwordEntered)
            .sink {
                if $0 != $1 {
                    self.state.checkPasswordMessage.send((.error, "비밀번호가 일치하지 않습니다."))
                } else {
                    self.state.checkPasswordMessage.send((.success, "비밀번호가 일치합니다."))
                }
            }.store(in: &cancellables)
        
        action.userNameEntered
            .sink {
                if $0.isEmpty {
                    self.state.userNameMessage.send((.error, "이름은 필수 입력 항목입니다."))
                } else {
                    self.state.userNameMessage.send((.success, ""))
                }
            }.store(in: &cancellables)
        
        let requestLogin = self.action.nextButtonTapped
            .map { _ -> AnyPublisher<Response<ResponseResult>, Error> in
                let userId = self.action.userIdEntered.value
                let password = self.action.passwordEntered.value
                return self.signUpRespository.signUp(userId: userId, password: password)
            }.share()
        
        requestLogin
            .switchToLatest()
            .sink(receiveCompletion: { data in
                print("실패했네요!")
            }, receiveValue: { data in
                print("성공했따고??")
            }).store(in: &cancellables)
    }
}
