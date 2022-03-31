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
        let userIdState = CurrentValueSubject<InputState, Never>(.none)
        let passwordState = CurrentValueSubject<InputState, Never>(.none)
        let checkPasswordState = CurrentValueSubject<InputState, Never>(.none)
        let userNameState = CurrentValueSubject<InputState, Never>(.none)
        
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
                state.userIdState.map { _ in },
                state.passwordState.map { _ in },
                state.checkPasswordState.map { _ in },
                state.userNameState.map { _ in })
            .map {
                if self.state.userIdState.value == .success,
                   self.state.passwordState.value == .success,
                   self.state.checkPasswordState.value == .success,
                   self.state.userNameState.value == .success {
                    return true
                }
                return false
            }
            .sink(receiveValue: self.state.isEnabledNextButton.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserId
            .map {
                if $0.isEmpty {
                    return .none
                }
                if CommonString.validatePredicate($0, format: "[A-Za-z0-9_-]{5,20}") {
                    return .success
                } else { return .errorUserId }
            }
            .sink(receiveValue: self.state.userIdState.send(_:))
            .store(in: &cancellables)
        
        action.enteredPassword
            .map {
                if $0.isEmpty {
                    return .none
                }
                
                if CommonString.validatePredicate($0, format: ".{8,16}") == false {
                    return .errorLengthLimited
                }
                
                if CommonString.vaildateRegex($0, pattern: "[A-Z]") == false {
                    return .errorNoCapitalLetters
                }
                
                if CommonString.vaildateRegex($0, pattern: "[0-9]") == false {
                    return .errorNoNumber
                }
                
                if CommonString.vaildateRegex($0, pattern: "[!@#$%^&*()_+=-]") == false {
                    return .errorNoSpecialCharacters
                }
                
                return .success
            }
            .sink(receiveValue: self.state.passwordState.send(_:))
            .store(in: &cancellables)
        
        action.enteredCheckPassword
            .combineLatest(action.enteredPassword)
            .map { $0 != $1 ? .errorNotMatch : .success }
            .sink(receiveValue: self.state.checkPasswordState.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserName
            .map { $0.isEmpty ? .errorNoInput : .success }
            .sink(receiveValue: self.state.userNameState.send(_:))
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

extension SignUpModel {
    enum InputState {
        case none
        case success
        case errorUserId
        case errorLengthLimited
        case errorNoCapitalLetters
        case errorNoNumber
        case errorNoSpecialCharacters
        case errorNotMatch
        case errorNoInput
    }
}
