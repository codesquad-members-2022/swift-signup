//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit
import OSLog

final class SignUpViewController: UIViewController {
    
    //view
    private let stackView = UIStackView(frame: .zero)
    private let nextButton = SignUpNextButton(frame: .zero)
    private var IDInputView:SignUpInputViewable?
    private var passwordInputView:SignUpInputViewable?
    private var passwordRecheckInputView:SignUpInputViewable?
    private var nameInputView:SignUpInputViewable?
    
    //network
    private var signUpNetwork = SignUpNetwork()
    //model that if use get method
    private var registeredID:UserID = UserID()
    //model that if use post method
    private var postResult:PostResult?
    
    //RegularExpression
    private var regualrExpressionChecker:RegularExpressionCheckable?
    
    //creator
    private var inputViewCreator:SignUpInputViewCreator?
    
    //inputIsValidate?
    private var signUpViewTextFieldManger:SignUpViewTextFieldManger?
    private var isValidate:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
        getRequest()
    }
    
    private func postRequest(userInfo:UserInfo) {
        signUpNetwork.postRequest(postBody: userInfo) { [weak self] (result:Result<PostResult,SignUpNetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let postResult):
                self.postResult = postResult
            case .failure(let error):
                os_log(.error, "\(error.localizedDescription)")
                return
            }
        }
    }
    
    
    private func getRequest() {
        signUpNetwork.getRequest { [weak self] (result: Result<UserID, SignUpNetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let userID):
                self.registeredID = userID
            case .failure(let error):
                os_log(.error, "\(error.localizedDescription)")
                return
            }
        }
    }
    
    private func configureSignUpView() {
        setTitle()
        configureNextButton()
        configureStackView()
    }
    
    //StackView
    private func configureStackView() {
        let constant:CGFloat = 32.0
        let inputViewComponents = configureInputViewComponents()
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        inputViewComponents.forEach{ inputViewable in
            guard let view = inputViewable as? SignUpInputView else { return }
            stackView.addArrangedSubview(view)
            view.delegate = self
        }
        
        self.view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: constant).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -constant).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor,constant: -constant).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: constant / 2).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    //title
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .blue
        self.navigationItem.titleView = label
    }
    
    //inputViewComponent
    private func configureInputViewComponents() -> [SignUpInputViewable?]{
        inputViewCreator(creator: SignUpInputViewFactory())
        guard let factory = inputViewCreator else { return [] }
        
        IDInputView = factory.makeSignUpViewComponent(
            id: InputViewComponent.id.id,
            labelText: InputViewComponent.id.label,
            placeHolder:InputViewComponent.id.placeHolder
        )
        passwordInputView = factory.makeSignUpViewComponent(
            id: InputViewComponent.password.id,
            labelText: InputViewComponent.password.label,
            placeHolder: InputViewComponent.password.placeHolder
        )
        passwordRecheckInputView = factory.makeSignUpViewComponent(
            id: InputViewComponent.passwordRecheck.id,
            labelText: InputViewComponent.passwordRecheck.label,
            placeHolder: InputViewComponent.passwordRecheck.placeHolder
        )
        nameInputView = factory.makeSignUpViewComponent(
            id: InputViewComponent.name.id,
            labelText: InputViewComponent.name.label,
            placeHolder: InputViewComponent.name.placeHolder
        )
        return [IDInputView,passwordInputView,passwordRecheckInputView,nameInputView]
    }
    
    //button
    private func configureNextButton() {
        let bottomInset:CGFloat = 300.0
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -bottomInset).isActive = true
    }
    
    //MARK: -- injection
    private func inputViewCreator(creator:SignUpInputViewCreator) {
        self.inputViewCreator = creator
    }
    
    private func inputExpressionChecker(checker:RegularExpressionCheckable) {
        self.regualrExpressionChecker = checker
    }
}

extension SignUpViewController:InputTextFieldDelegate {
    func textFieldEndEditing(inputViewID: String, textField: UITextField) {
        switch inputViewID {
        case InputViewComponent.id.id:
            //set checker
            inputExpressionChecker(checker: IDExpressionChecker())
            
            //set TextFieldmanger
            signUpViewTextFieldManger = SignUpViewTextFieldManger(
                signUpView: IDInputView,
                regualrExpressionChecker: regualrExpressionChecker
            )
            //CheckText
            signUpViewTextFieldManger?.isValidateText()

        case InputViewComponent.password.id:
            inputExpressionChecker(checker: PasswordExpressionChecker())
            
            signUpViewTextFieldManger = SignUpViewTextFieldManger(
                signUpView: passwordInputView,
                regualrExpressionChecker: regualrExpressionChecker
            )
            
            signUpViewTextFieldManger?.isValidateText()
        case InputViewComponent.passwordRecheck.id:
            
            guard let inputtedPassword = passwordInputView,
                  let inputView = passwordRecheckInputView else { return }
            
            guard let password = inputtedPassword.getTextFieldText(),
                  let text = inputView.getTextFieldText() else { return }

            isValidate = false
            isValidate = (password == text)
            
        default:
            break
        }
    }
}
