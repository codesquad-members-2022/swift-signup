//
//  InputViewComponent.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/31.
//

import Foundation

struct InputViewComponent {
    static let id:(id:String, label:String, placeHolder:String) = (id:"ID", label:"아이디", placeHolder:"영문 대/소문자, 숫자, 특수기호(_,-) 5~20자")
    static let password:(id:String, label:String, placeHolder:String) = (id:"password", label:"비밀번호",
                                                            placeHolder:"영문 대/소문자, 숫자, 특수문자(!@#$% 8~16자")
    static let passwordRecheck:(id:String, label:String, placeHolder:String) = (id:"passwordRecheck", label:"비밀번호 재확인", placeHolder:"")
    static let name:(id:String, label:String, placeHolder:String) = (id:"name", label:"이름", placeHolder:"")
}
