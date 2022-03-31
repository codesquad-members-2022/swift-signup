//
//  UserInfoModel.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import Combine

class UserInfoModel {
    struct Action {
        let selectBirthDate = PassthroughSubject<Date, Never>()
        let selectGender = PassthroughSubject<Gender, Never>()
        let enteredEmail = PassthroughSubject<String, Never>()
        let enteredPhoneNumber = PassthroughSubject<String, Never>()
        
        let presentDatePickerView = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let birthDate = CurrentValueSubject<Date?, Never>(nil)
        let gender = CurrentValueSubject<Gender, Never>(.female)
        let emailMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        let phoneNumberMessage = CurrentValueSubject<(Bool, String), Never>((false, ""))
        
        let presentDatePickerView = PassthroughSubject<Date, Never>()
        let isEnabledNextButton = PassthroughSubject<Bool, Never>()
    }
    
    var cancellables = Set<AnyCancellable>()
    let action = Action()
    let state = State()
    
    init() {
        
        Publishers
            .Merge3(
                state.birthDate.map { _ in },
                state.emailMessage.map { _ in },
                state.phoneNumberMessage.map { _ in }
            )
            .map {
                if self.state.birthDate.value != nil,
                   self.state.emailMessage.value.0,
                   self.state.phoneNumberMessage.value.0 {
                    return true
                }
                return false
            }
            .sink(receiveValue: self.state.isEnabledNextButton.send(_:))
            .store(in: &cancellables)
        
        action.presentDatePickerView
            .map { self.state.birthDate.value ?? Date.now }
            .sink(receiveValue: self.state.presentDatePickerView.send(_:))
            .store(in: &cancellables)
        
        action.selectBirthDate
            .sink(receiveValue: self.state.birthDate.send(_:))
            .store(in: &cancellables)
        
        action.selectGender
            .sink(receiveValue: self.state.gender.send(_:))
            .store(in: &cancellables)
        
        action.enteredEmail
            .map {
                if $0.validatePredicate(format: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$") {
                    return (true, "사용가능한 메일입니다.")
                }
                return (false, "이메일 주소를 다시 확인해주세요.")
            }
            .sink(receiveValue: self.state.emailMessage.send(_:))
            .store(in: &cancellables)
        
        action.enteredPhoneNumber
            .map {
                if $0.validatePredicate(format: "^01([0-9])([0-9]{3,4})([0-9]{4})$") {
                    return (true, "사용가능한 번호입니다.")
                }
                return (false, "형식에 맞지 않는 번호입니다.")
            }
            .sink(receiveValue: self.state.phoneNumberMessage.send(_:))
            .store(in: &cancellables)
    }
}
