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
    
    let userId: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "아이디"
        inputView.textContentType = .name
        inputView.attributedPlaceholder = NSAttributedString(string: "영문 소문자, 숫자, 특수기호(_,-), 5~20자", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        inputView.keyBoardType = .namePhonePad
        return inputView
    }()
    
    let password: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "비밀번호"
        inputView.textContentType = .password
        inputView.attributedPlaceholder = NSAttributedString(string: "영문 대/소문자, 숫자, 특수문자(!@#$%) 8~16자", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        inputView.isSecureTextEntry = true
        inputView.keyBoardType = .default
        return inputView
    }()
    
    let checkPassword: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.textContentType = .password
        inputView.title = "비밀번호 재확인"
        inputView.isSecureTextEntry = true
        inputView.keyBoardType = .default
        return inputView
    }()
    
    let userName: InputTextField = {
        let inputView = InputTextFieldView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.title = "이름"
        inputView.textContentType = .name
        inputView.keyBoardType = .namePhonePad
        return inputView
    }()
    
    let nextButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("다음", for: .normal)
        button.setImage(UIImage(named: "ic_rightArrow")?.withTintColor(.systemGreen), for: .normal)
        button.setImage(UIImage(named: "ic_rightArrow")?.withTintColor(.systemGray2), for: .disabled)
        button.setTitleColor(.systemGreen, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        return button
    }()
    
    var inputViews: [UIView] {
        [self.userId.view, self.password.view, self.checkPassword.view, self.userName.view]
    }
    
    var cancellables = Set<AnyCancellable>()
    
    let model = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func bind() {
        //UserId
        userId.changedPublisher
            .sink(receiveValue: self.model.action.enteredUserId.send(_:))
            .store(in: &cancellables)
                
        model.state.userIdState
            .map {
                if $0 == .success {
                    return (true, "사용 가능한 아이디입니다.")
                }
                return (false, $0.message)
            }
            .sink(receiveValue: self.userId.setMessage(_:_:))
            .store(in: &cancellables)
        
        //Password
        password.changedPublisher
            .sink(receiveValue: self.model.action.enteredPassword.send(_:))
            .store(in: &cancellables)
        
        model.state.passwordState
            .map {
                if $0 == .success {
                    return (true, "안전한 비밀번호입니다.")
                }
                return (false, $0.message)
            }
            .sink(receiveValue: self.password.setMessage(_:_:))
            .store(in: &cancellables)
        
        //CheckPassword
        checkPassword.changedPublisher
            .sink(receiveValue: self.model.action.enteredCheckPassword.send(_:))
            .store(in: &cancellables)
        
        model.state.checkPasswordState
            .dropFirst()
            .map { isSuccess in
                if isSuccess {
                    return (true, "비밀번호가 일치합니다.")
                }
                return (false, "비밀번호가 일치하지 않습니다.")
            }
            .sink(receiveValue: self.checkPassword.setMessage(_:_:))
            .store(in: &cancellables)
        
        //UserName
        userName.changedPublisher
            .sink(receiveValue: self.model.action.enteredUserName.send(_:))
            .store(in: &cancellables)
        
        model.state.userNameState
            .dropFirst()
            .map { isSuccess in
                if isSuccess {
                    return (true , "")
                }
                return (false, "이름은 필수 입력 항목입니다")
            }
            .sink(receiveValue: self.userName.setMessage(_:_:))
            .store(in: &cancellables)
        
        //NextButton
        nextButton.publisher(for: .touchUpInside)
            .sink(receiveValue: self.model.action.tappedNextButton.send)
            .store(in: &cancellables)
        
        model.state.isEnabledNextButton
            .sink { isEnabled in
                self.nextButton.isEnabled = isEnabled
            }.store(in: &cancellables)
        
        model.state.presentNextPage
            .sink {
                let viewController = UserInfoViewController()
                viewController.modalPresentationStyle = .custom
                viewController.transitioningDelegate = self
                self.present(viewController, animated: true)
            }.store(in: &cancellables)
        
        Publishers
            .Merge8(
                self.userId.beginEditionPublisher.map { (self.userId, true) },
                self.userId.endEditionPublisher.map { (self.userId, false) },
                self.password.beginEditionPublisher.map { (self.password, true) },
                self.password.endEditionPublisher.map { (self.password, false) },
                self.checkPassword.beginEditionPublisher.map { (self.checkPassword, true) },
                self.checkPassword.endEditionPublisher.map { (self.checkPassword, false) },
                self.userName.beginEditionPublisher.map { (self.userName, true) },
                self.userName.endEditionPublisher.map { (self.userName, false) }
            )
            .sink { targetView, isFocused in
                targetView.setFocused(isFocused)
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
        inputViews.forEach { stackView.addArrangedSubview($0) }
        stackView.bottomAnchor.constraint(equalTo: inputViews[inputViews.count - 1].bottomAnchor).isActive = true
        
        self.view.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension SignUpViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        RightToLeftTransition(.present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        RightToLeftTransition(.dismiss)
    }
}
