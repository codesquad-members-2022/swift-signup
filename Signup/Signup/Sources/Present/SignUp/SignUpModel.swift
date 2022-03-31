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
        let userIdState = CurrentValueSubject<ValidateResultType, Never>(.none)
        let passwordState = CurrentValueSubject<ValidateResultType, Never>(.none)
        let checkPasswordState = CurrentValueSubject<Bool, Never>(false)
        let userNameState = CurrentValueSubject<Bool, Never>(false)
        
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
                self.state.userIdState.value == .success &&
                self.state.passwordState.value == .success &&
                self.state.checkPasswordState.value &&
                self.state.userNameState.value
            }
            .sink(receiveValue: self.state.isEnabledNextButton.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserId
            .map { Verification<UserIdVelidate>().check(text: $0)}
            .sink(receiveValue: self.state.userIdState.send(_:))
            .store(in: &cancellables)
        
        action.enteredPassword
            .map { Verification<PasswordVaildate>().check(text: $0)}
            .sink(receiveValue: self.state.passwordState.send(_:))
            .store(in: &cancellables)
        
        action.enteredCheckPassword
            .combineLatest(action.enteredPassword)
            .map { $0 != $1 }
            .sink(receiveValue: self.state.checkPasswordState.send(_:))
            .store(in: &cancellables)
        
        action.enteredUserName
            .map { !$0.isEmpty }
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
