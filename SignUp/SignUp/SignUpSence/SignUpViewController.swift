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
    private var inputViewComponents:[SignUpInputViewable?] = []
    
    //network
    private var signUpNetwork = SignUpNetwork()
    //model that if use get method
    private var registeredID:UserID = UserID()
    //model that if use post method
    private var postResult:PostResult?

    //creator
    private var inputViewCreator:SignUpInputViewCreator?
    private var textFieldMangerCreator:TextFieldMangerCreator?
    
    //inputIsValidate?
    private var signUpViewTextFieldManger:SignUpInputViewTextFieldMangerable?
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
        
        IDInputView = factory.makeSignUpViewComponent(inputModel: IDInputComponentModel() )
        passwordInputView = factory.makeSignUpViewComponent(inputModel: PasswordInputComponentModel() )
        passwordRecheckInputView = factory.makeSignUpViewComponent(inputModel: PasswordRecheckInputComponentModel() )
        nameInputView = factory.makeSignUpViewComponent(inputModel: NameInputComponentModel() )
        
        inputViewComponents = [IDInputView,passwordInputView,passwordRecheckInputView,nameInputView]
        return inputViewComponents
    }
    
    //button
    private func configureNextButton() {
        let bottomInset:CGFloat = 300.0
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -bottomInset).isActive = true
    }
    
    private func findSpecificInputView(inputViewID: inputViewIdentifierable) -> SignUpInputViewable? {
        let selectedInputView = inputViewComponents.first {
            $0?.getIdentifier()?.id == inputViewID.id
        }
        return selectedInputView ?? nil
    }
    
    //MARK: -- injection
    private func inputViewCreator(creator:SignUpInputViewCreator) {
        self.inputViewCreator = creator
    }
    
    private func inputTextFieldMangerCreator(creator:TextFieldMangerCreator) {
        self.textFieldMangerCreator = creator
    }
}

extension SignUpViewController:SignUpInputTextFieldDelegate {

    func textFieldEndEditing(inputViewID: inputViewIdentifierable, textField: UITextField) {
        //injection creator
        inputTextFieldMangerCreator(creator: TextFieldMangerFactory())
        
        //make factory and find specificInputView
        guard let factory = textFieldMangerCreator,
              let inputView = self.findSpecificInputView(inputViewID: inputViewID)
              else { return }
        signUpViewTextFieldManger = factory.makeTextFieldManger(id: inputViewID)
        
        //Check Text & return result
        guard let checkedResult = signUpViewTextFieldManger?.validateText(signUpInputView: inputView) else { return }
        
        //resultText that will appear view
        guard let textFieldAlertText = signUpViewTextFieldManger?.InputResultText(checkedResult: checkedResult) else { return }
        
        inputView.setAlertText(text: textFieldAlertText)
    }
}
