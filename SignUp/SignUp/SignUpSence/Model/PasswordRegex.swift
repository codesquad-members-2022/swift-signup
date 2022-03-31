//
//  PasswordRegex.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//


enum PasswordRegex:String,CaseIterable {
    case lowerRegex = "(?=.*[a-z])"
    case upperRegex = "(?=.*[A-Z])"
    case numberRegexs = "(?=.*[0-9])"
    case specialCharacterRegexs = "(?=.*[!@#$%^&*])"
    case lengthRegexs = ".{8,16}"
}
