//
//  SigninViewController.swift
//  Signup
//
//  Created by juntaek.oh on 2022/03/29.
//

import Foundation
import UIKit

class SigninViewController: UIViewController {
    private var idLabel: UILabel!
    private var pswLabel: UILabel!
    private var checkPswLabel: UILabel!
    private var nameLabel: UILabel!
    
    private var idTextField: UITextField!
    private var pswTextField: UITextField!
    private var checkPswTextField: UITextField!
    private var nameTextField: UITextField!
    
    private var validIdLabel: UILabel!
    
    var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setNavigationBar()
        setAttributes()
        setTextFieldDelegate()
        TextFieldValueChecker.valueChecker.httpGetId()
    }
    
    private func setAttributes(){
        setIdLabel()
        setIdTextField()
        setPswLabel()
        setPswTextField()
        setCheckPswLabel()
        setCheckPswTextField()
        setNameLabel()
        setNameTextField()
        setValidIdLabel()
    }
    
    private func setTextFieldDelegate(){
        idTextField.delegate = self
        pswTextField.delegate = self
        checkPswTextField.delegate = self
        nameTextField.delegate = self
    }
    
    func setNavigationBar(){
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)
        ]
        self.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
}


// MARK: - Use case: TextField Delegate and function

extension SigninViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if textField === idTextField{
            let newText = text + string
            
            switch TextFieldValueChecker.valueChecker.checkID(text: newText){
            case CheckValidIDCase.invalid
                : validIdLabel.text = CheckValidIDCase.invalid.showReason()
                  validIdLabel.textColor = .systemRed
            case .shortLength
                : validIdLabel.text = CheckValidIDCase.shortLength.showReason()
                  validIdLabel.textColor = .systemRed
            case .longLength
                : validIdLabel.text = CheckValidIDCase.longLength.showReason()
                  validIdLabel.textColor = .systemRed
            case .valid
                : validIdLabel.text = CheckValidIDCase.valid.showReason()
                  validIdLabel.textColor = .systemGreen
            case .usedId
                : validIdLabel.text = CheckValidIDCase.usedId.showReason()
                validIdLabel.textColor = .systemRed
            }
            
            changeTextFieldLayer(textField: textField)
        }
        
        return true
    }
    
    func changeTextFieldLayer(textField: UITextField){
        if check{
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        } else{
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func textFieldDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}


// MARK: - Use case: Configure attributes

extension SigninViewController{
    private func setIdLabel(){
        idLabel = UILabel(frame: CGRect(x: 40, y: (navigationController?.navigationBar.frame.maxY ?? 0) + 60, width: view.frame.width - 80, height: 30))
        idLabel.text = "아이디"
        idLabel.font = UIFont.boldSystemFont(ofSize: 15)
        idLabel.textColor = .black
        
        self.view.addSubview(idLabel)
    }
    
    private func setIdTextField(){
        idTextField = UITextField(frame: CGRect(x: 40, y: idLabel.frame.maxY, width: view.frame.width - 80, height: 30))
        idTextField.attributedPlaceholder = NSAttributedString(string: "영문 소문자, 숫자, 특수기호(_-), 5-20자", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)])
        
        textFieldCommonSetting(textField: idTextField)
        
        self.view.addSubview(idTextField)
    }
    
    private func setValidIdLabel(){
        validIdLabel = UILabel(frame: CGRect(x: 40, y: idTextField.frame.maxY, width: view.frame.width - 80, height: 30))
        validIdLabel.font = UIFont.systemFont(ofSize: 10)
        
        self.view.addSubview(validIdLabel)
    }
    
    private func setPswLabel(){
        pswLabel = UILabel(frame: CGRect(x: 40, y: idTextField.frame.maxY + 30, width: view.frame.width - 80, height: 30))
        pswLabel.text = "비밀번호"
        pswLabel.font = UIFont.boldSystemFont(ofSize: 15)
        pswLabel.textColor = .black
        
        self.view.addSubview(pswLabel)
    }
    
    private func setPswTextField(){
        pswTextField = UITextField(frame: CGRect(x: 40, y: pswLabel.frame.maxY, width: view.frame.width - 80, height: 30))
        pswTextField.attributedPlaceholder = NSAttributedString(string: "영문 대/소문자, 숫자, 특수문자(!@#$%), 8-16자", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)])
        
        textFieldCommonSetting(textField: pswTextField)
        pswTextField.isSecureTextEntry = true
        
        self.view.addSubview(pswTextField)
    }
    
    private func setCheckPswLabel(){
        checkPswLabel = UILabel(frame: CGRect(x: 40, y: pswTextField.frame.maxY + 30, width: view.frame.width - 80, height: 30))
        checkPswLabel.text = "비밀번호 재확인"
        checkPswLabel.font = UIFont.boldSystemFont(ofSize: 15)
        checkPswLabel.textColor = .black
        
        self.view.addSubview(checkPswLabel)
    }
    
    private func setCheckPswTextField(){
        checkPswTextField = UITextField(frame: CGRect(x: 40, y: checkPswLabel.frame.maxY, width: view.frame.width - 80, height: 30))
        textFieldCommonSetting(textField: checkPswTextField)
        
        self.view.addSubview(checkPswTextField)
    }
    
    private func setNameLabel(){
        nameLabel = UILabel(frame: CGRect(x: 40, y: checkPswTextField.frame.maxY + 30, width: view.frame.width - 80, height: 30))
        nameLabel.text = "이름"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textColor = .black
        
        self.view.addSubview(nameLabel)
    }
    
    private func setNameTextField(){
        nameTextField = UITextField(frame: CGRect(x: 40, y: nameLabel.frame.maxY, width: view.frame.width - 80, height: 30))
        textFieldCommonSetting(textField: nameTextField)
        
        self.view.addSubview(nameTextField)
    }
    
    private func textFieldCommonSetting(textField: UITextField){
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = UITextField.ViewMode.always
        
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
    }
}

