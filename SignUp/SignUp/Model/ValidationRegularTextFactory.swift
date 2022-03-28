//
//  ValidationRegularTextFactory.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

class ValidationRegularTextFactory {
    
    static func makeRegularExpression(as validType: ValidationRegularText.ValidType) -> ValidationRegularText? {
        switch validType {
        case .id:
            return idMaker()
        case .password:
            return passwordMaker()
        case .birthDay:
            return birthDayMaker()
        case .emailAddress:
            return emailAddressMaker()
        case .phoneNumber:
            return phoneNumberMaker()
        case .favoriteCategory:
            return favoriteCategoryMaker()
        }
    }
    
    // MARK: - Factory Methods(하나로 만들 수도 있을 것 같음.)
    private static func idMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .id)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func passwordMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .password)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func birthDayMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .birthDay)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func emailAddressMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .emailAddress)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func phoneNumberMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .phoneNumber)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func favoriteCategoryMaker() -> ValidationRegularText? {
        do {
            return try ValidationRegularText(pattern: "", options: .caseInsensitive, as: .favoriteCategory)
        } catch {
            print(error)
            return nil
        }
    }
}
