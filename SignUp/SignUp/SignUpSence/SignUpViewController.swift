//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let stackView = UIStackView()
    
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
        let inputViewComponents = configureInputViewComponents()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        inputViewComponents.forEach{ inputViewable in
            guard let view = inputViewable as? SignUpInputViewComponent else { return }
            stackView.addArrangedSubview(view)
        }
        
        self.view.addSubview(stackView)
        
        stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 32).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureInputViewComponents() -> [SignUpInputViewable]{
        let IDComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "아이디", placeHolder: "영문 대/소문자, 숫자, 특수기호(_,-) 5~20자")
        let passwordComponet = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "비밀번호", placeHolder: "영문 대/소문자, 숫자, 특수문자(!@#$% 8~16자")
        let passwordRecheckComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "비밀번호 재확인", placeHolder: "")
        let nameComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "이름", placeHolder: "")
        
        return [IDComponent,passwordComponet,passwordRecheckComponent,nameComponent]
    }
    
}

