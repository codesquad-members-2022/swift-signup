//
//  ViewController.swift
//  SignupApp
//
//  Created by 김동준 on 2022/03/28.
//

import UIKit

class SignupViewController: UIViewController {
    
    private var signupManagable: SignManagable?
    private let textFieldDeleagate = TextFieldDelegate()
    
    @IBOutlet weak var idTextField: IDTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var passwordCheckTextField: PasswordCheckTextField!
    @IBOutlet weak var nameTextField: NameTextField!
    func injectDependency(signupDependency: SignupDependencyUsable){
        self.signupManagable = signupDependency.getManagable()
    }
    
    private func pullDependency(){
        ComposeDependency.pull(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullDependency()
        view.backgroundColor = .systemGray5
        setTextfieldsDelegate()
    }
    
    private func setTextfieldsDelegate(){
        idTextField.delegate = textFieldDeleagate
        passwordTextField.delegate = textFieldDeleagate
        passwordCheckTextField.delegate = textFieldDeleagate
        nameTextField.delegate = textFieldDeleagate
    }
}
