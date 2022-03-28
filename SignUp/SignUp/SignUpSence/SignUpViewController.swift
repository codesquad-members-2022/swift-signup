//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let stackView = UIStackView(frame: .zero)
    private let nextButton = SignUpNextButton(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
    }

    private func configureSignUpView() {
        setTitle()
        configureNextButton()
        configureStackView()
    }
    
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        self.navigationItem.titleView = label
    }
    
    private func configureStackView() {
        let constant:CGFloat = 32.0
        let inputViewComponents = configureInputViewComponents()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        inputViewComponents.forEach{ inputViewable in
            guard let view = inputViewable as? SignUpInputViewComponent else { return }
            stackView.addArrangedSubview(view)
        }
        
        self.view.addSubview(stackView)
    
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: constant).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -constant).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor,constant: -constant).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: constant / 2).isActive = true
        
    }
    
    private func configureInputViewComponents() -> [SignUpInputViewable]{
        let IDComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "아이디", placeHolder: "영문 대/소문자, 숫자, 특수기호(_,-) 5~20자")
        let passwordComponet = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "비밀번호", placeHolder: "영문 대/소문자, 숫자, 특수문자(!@#$% 8~16자")
        let passwordRecheckComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "비밀번호 재확인", placeHolder: "")
        let nameComponent = SignUpInputViewFactory.makeSignUpViewComponent(labelText: "이름", placeHolder: "")
        
        return [IDComponent,passwordComponet,passwordRecheckComponent,nameComponent]
    }
    
    private func configureNextButton() {
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -300).isActive = true
    }
}

