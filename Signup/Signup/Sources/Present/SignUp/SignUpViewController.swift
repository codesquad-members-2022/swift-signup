//
//  ViewController.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import UIKit
import Combine

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
        inputView.title = "아이디"
        inputView.textContentType = .name
        inputView.placeholder = "  영문 소문자, 숫자, 특수기호(_,-), 5~20자"
        return inputView
    }()
    
    let password: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "비밀번호"
        inputView.textContentType = .password
        inputView.placeholder = "  영문 대/소문자, 숫자, 특수문자(!@#$%) 8~16자"
        inputView.isSecureTextEntry = true
        return inputView
    }()
    
    let checkPassword: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.textContentType = .password
        inputView.title = "비밀번호 재확인"
        inputView.placeholder = ""
        inputView.isSecureTextEntry = true
        return inputView
    }()
    
    let userName: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "이름"
        inputView.textContentType = .name
        inputView.placeholder = ""
        return inputView
    }()
    
    var inputViews: [InputView] {
        [self.userId, self.password, self.checkPassword, self.userName]
    }
    
    var cancellables = Set<AnyCancellable>()
    
    let model = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
    }
    
    private func bind() {
        userId.textPublisher
            .sink {
                self.model.action.userIdEntered.send($0)
            }.store(in: &cancellables)
                
        model.state.userIdMessage
            .sink {
                self.userId.setMessage($1, type: $0)
            }.store(in: &cancellables)
        
        password.textPublisher
            .sink {
                self.model.action.passwordEntered.send($0)
            }.store(in: &cancellables)
        
        model.state.passwordMessage
            .sink {
                self.password.setMessage($1, type: $0)
            }.store(in: &cancellables)
        
        checkPassword.textPublisher
            .sink {
                self.model.action.checkPasswordEntered.send($0)
            }.store(in: &cancellables)
        
        model.state.checkPasswordMessage
            .sink {
                self.checkPassword.setMessage($1, type: $0)
            }.store(in: &cancellables)
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
        }
        
        stackView.bottomAnchor.constraint(equalTo: userName.bottomAnchor).isActive = true
    }
}

