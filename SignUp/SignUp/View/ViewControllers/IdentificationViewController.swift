//
//  IdentificationViewController.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class IdentificationViewController: UIViewController {
    
    @IBOutlet weak var nextButtonView: UIView!
    
    @IBOutlet weak var idTextField: CustomTextField! {
        didSet {
            idTextField.validator = ValidationRegularText(as: .id)
        }
    }
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            passwordTextField.validator = ValidationRegularText(as: .password)
        }
    }
    
    var validationCompareComponent: ValidationCompareComponent?
    @IBOutlet weak var passwordConfirmTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = CustomSegueButton(with: nextButtonView.bounds, as: "다음", using: #selector(nextButtonTouchUpInside(_:)))
        nextButtonView.addSubview(button)
        validationCompareComponent = ValidationCompareComponent(comparable: passwordTextField) { [weak self] result in
            if result {
                self?.passwordConfirmTextField.didEndValidate()
            }
        }
        passwordConfirmTextField.validator = validationCompareComponent
    }
    
    @objc func nextButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "PrivateInfoViewController", sender: self)
    }
}
