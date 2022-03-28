//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    
    let IDComponent = SignUpViewComponent(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
        
    }
    
    private func configureSignUpView() {
        setTitle()
        configureViewComponents()
    }
    
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        self.navigationItem.titleView = label
    }
    
    private func configureViewComponents() {
        IDComponent.labelText(text: "아이디")
        IDComponent.placeholder(text: "영문 대/소문자, 숫자, 특수기호(!@#$%) 8~16자")
        
        [IDComponent].forEach{ self.view.addSubview($0) }
    }
    
}

