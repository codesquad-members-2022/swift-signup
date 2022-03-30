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
        let userIdEntered = CurrentValueSubject<String, Never>("")
        let passwordEntered = CurrentValueSubject<String, Never>("")
        let checkPasswordEntered = PassthroughSubject<String, Never>()
        let userNameEntered = PassthroughSubject<String, Never>()
        let nextButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let userIdMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let passwordMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let checkPasswordMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let userNameMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let isNextButtonEnabled = PassthroughSubject<Bool, Never>()
        let presentNextPage = PassthroughSubject<Void, Never>()
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    let signUpRespository: SignUpRepository = SignUpRepositoryImpl()
    
    init() {
        Publishers
            .Merge4(
                action.userIdEntered.map { _ in },
                action.passwordEntered.map { _ in },
                action.checkPasswordEntered.map { _ in },
                action.userNameEntered.map { _ in })
            .map {
                if self.state.userIdMessage.value.0,
                   self.state.passwordMessage.value.0,
                   self.state.checkPasswordMessage.value.0,
                   self.state.userNameMessage.value.0 {
                    return true
                }
                return false
            }
            .sink(receiveValue: self.state.isNextButtonEnabled.send(_:))
            .store(in: &cancellables)
        
        action.userIdEntered
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
        
        action.passwordEntered
            .map {
                if $0.isEmpty {
                    return (false ,"")
                }
                
                if $0.count < 8 || $0.count > 16 {
                    return (false , "8자 이상 16자 이하로 입력해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[A-Z]") == false {
                    return (false , "영문 대문자를 최소 1자 이상 포함해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[0-9]") == false {
                    return (false , "숫자를 최소 1자 이상 포함해주세요.")
                }
                
                if $0.vaildateRegex(pattern: "[!@#$%^&*()_+=-]") == false {
                    return (false , "특수문자를 최소 1자 이상 포함해주세요.")
                }
                
                return (true , "안전한 비밀번호입니다.")
            }
            .sink(receiveValue: self.state.passwordMessage.send(_:))
            .store(in: &cancellables)
        
        action.checkPasswordEntered
            .combineLatest(action.passwordEntered)
            .map {
                if $0 != $1 {
                    return (false , "비밀번호가 일치하지 않습니다.")
                } else {
                    return (true , "비밀번호가 일치합니다.")
                }
            }
            .sink(receiveValue: self.state.checkPasswordMessage.send(_:))
            .store(in: &cancellables)
        
        action.userNameEntered
            .map {
                if $0.isEmpty {
                    return (false , "이름은 필수 입력 항목입니다.")
                } else {
                    return (true , "비밀번호가 일치합니다.")
                }
            }
            .sink(receiveValue: self.state.userNameMessage.send(_:))
            .store(in: &cancellables)
        
        self.action.nextButtonTapped
            .map { _ -> AnyPublisher<Response<ResponseResult>, Error> in
                let userId = self.action.userIdEntered.value
                let password = self.action.passwordEntered.value
                return self.signUpRespository.signUp(userId: userId, password: password)
            }
            .sink(receiveCompletion: { data in
                //TODO: 회원가입 실패 시 처리
            }, receiveValue: { data in
                self.state.presentNextPage.send()
            }).store(in: &cancellables)
    }
}
