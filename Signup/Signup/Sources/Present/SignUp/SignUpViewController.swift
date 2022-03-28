//
//  ViewController.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import UIKit

class SignUpViewController: UIViewController {

    let signUpTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입"
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let userId: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title.text = "아이디"
        inputView.textField.placeholder = "  영문 소문자, 숫자, 특수기호(_,-), 5~20자"
        inputView.errorLabel.text = "이미 사용중인 아이디입니다."
        return inputView
    }()
    
    let password: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title.text = "비밀번호"
        inputView.textField.placeholder = "  영문 대/소문자, 숫자, 특수문자(!@#$%) 8~16자"
        inputView.errorLabel.text = "이미 사용중인 아이디입니다."
        return inputView
    }()
    
    let passwordCheck: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title.text = "비밀번호 재확인"
        inputView.textField.placeholder = ""
        inputView.errorLabel.text = "이미 사용중인 아이디입니다."
        return inputView
    }()
    
    let userName: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title.text = "이름"
        inputView.textField.placeholder = ""
        inputView.errorLabel.text = "이미 사용중인 아이디입니다."
        return inputView
    }()
    
    var inputViews: [InputView] {
        [self.userId, self.password, self.passwordCheck, self.userName]
    }
    
    let model = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
    }
    
    private func bind() {
        
//        model.action.nextButtonTapped.send()
//        model.action.userIdEntered.send("idididid")
//        model.action.passwordEntered.send("password")
        
//        model.action.nextButtonTapped.send()
//
//        model.action.userIdEntered.send("****")
//        model.action.passwordEntered.send("password")
//        model.action.userIdEntered.send("idididid1234")
//        model.action.userIdEntered.send("idididid123")
//        model.action.passwordEntered.send("password113")
    }
    
    private func attribute() {
        self.view.backgroundColor = .systemGray6
    }
    
    private func layout() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(signUpTitle)
        signUpTitle.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        signUpTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        signUpTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        signUpTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
        
        inputViews.forEach {
            stackView.addArrangedSubview($0)
//            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
        
        stackView.bottomAnchor.constraint(equalTo: userName.bottomAnchor).isActive = true
        
//        self.view.addSubview(userId)
//        userId.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 30).isActive = true
//        userId.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
//        userId.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
//        userId.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

