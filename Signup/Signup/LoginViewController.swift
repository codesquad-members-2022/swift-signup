//
//  ViewController.swift
//  Signup
//
//  Created by juntaek.oh on 2022/03/29.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginLabel: UILabel!
    private var idLabel: UILabel!
    private var pswLabel: UILabel!
    private var idTextField: UITextField!
    private var pswTextField: UITextField!
    private var loginButton: UIButton!
    private var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        attributesConfigure()
        hideKeyboardWithOutsideTapped()
        
        addSigninAction()
    }
    
    private func attributesConfigure(){
        loginLabelConfigure()
        idLabelConfigure()
        idTextFieldConfigure()
        pswLabelConfigure()
        pswTextFieldConfigure()
        loginButtonConfigure()
        signinButtonConfigure()
    }
}


// MARK: - Use case: TextField Delegate and function

extension LoginViewController: UITextFieldDelegate{
    // 추후 ID, PW 확인 기능 필요
    
    private func hideKeyboardWithOutsideTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}


// MARK: - Use case: Button action

extension LoginViewController{
    func addSigninAction(){
        self.signinButton.addTarget(self, action: #selector(presentSigninVC), for: .touchUpInside)
    }
    
    @objc func presentSigninVC(){
        let signinVC = SigninViewController()
        let navController = UINavigationController(rootViewController: signinVC)
        
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}


// MARK: - Use case: Configure attributes

extension LoginViewController{
    private func loginLabelConfigure(){
        loginLabel.text = "로그인"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 25)
        loginLabel.textColor = .systemGreen
    }
    
    private func idLabelConfigure(){
        idLabel = UILabel(frame: CGRect(x: 40, y: loginLabel.frame.maxY + 30, width: view.frame.width - 80, height: 30))
        idLabel.text = "아이디"
        idLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.view.addSubview(idLabel)
    }
    
    private func pswLabelConfigure(){
        pswLabel = UILabel(frame: CGRect(x: 40, y: idTextField.frame.maxY + 20, width: view.frame.width - 80, height: 30))
        pswLabel.text = "비밀번호"
        pswLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.view.addSubview(pswLabel)
    }
    
    private func idTextFieldConfigure(){
        idTextField = UITextField(frame: CGRect(x: 40, y: idLabel.frame.maxY, width: view.frame.width - 80, height: 40))
        textFieldCommonSetting(textField: idTextField)
        
        self.view.addSubview(idTextField)
    }
    
    private func pswTextFieldConfigure(){
        pswTextField = UITextField(frame: CGRect(x: 40, y: pswLabel.frame.maxY, width: view.frame.width - 80, height: 40))
        textFieldCommonSetting(textField: pswTextField)
        pswTextField.isSecureTextEntry = true
        
        self.view.addSubview(pswTextField)
    }
    
    private func textFieldCommonSetting(textField: UITextField){
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = UITextField.ViewMode.always
        
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func loginButtonConfigure(){
        loginButton = UIButton(frame: CGRect(x: loginLabel.center.x - 90, y: pswTextField.frame.maxY + 30, width: 80, height: 40))
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.systemGreen, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.systemGray.cgColor
        
        self.view.addSubview(loginButton)
    }
    
    private func signinButtonConfigure(){
        signinButton = UIButton(frame: CGRect(x: loginLabel.center.x + 10, y: pswTextField.frame.maxY + 30, width: 80, height: 40))
        signinButton.setTitle("회원가입", for: .normal)
        signinButton.setTitleColor(.systemGreen, for: .normal)
        signinButton.layer.borderWidth = 1
        signinButton.layer.borderColor = UIColor.systemGray.cgColor
        
        self.view.addSubview(signinButton)
    }
}
