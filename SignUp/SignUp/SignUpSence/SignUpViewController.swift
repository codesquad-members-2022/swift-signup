//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    let stackView = UIStackView()
    let IDComponent = SignUpViewComponent(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
    }

    private func configureSignUpView() {
        setTitle()
        configureStackView()
    }
    
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        self.navigationItem.titleView = label
    }
    
    private func configureStackView() {
        configureViewComponents()
        
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(IDComponent)
        self.view.addSubview(stackView)
        
        
        stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 32).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        

        
    }
    
    private func configureViewComponents() {
        IDComponent.labelText(text: "아이디")
        IDComponent.placeholder(text: "영문 대/소문자, 숫자, 특수기호(!@#$%) 8~16자")
    }
    
}

