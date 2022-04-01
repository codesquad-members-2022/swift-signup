//
//  InputComponentable.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

protocol InputComponentable {
    var id: inputViewIdentifierable { get }
    var labelText: String { get }
    var placeHolder: String { get }
    var checker:RegularExpressionCheckable? { get }
}
