//
//  IdentificationViewController.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class IdentificationViewController: UIViewController {
    
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var idTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = CustomSegueButton(with: nextButtonView.bounds, as: "다음", using: #selector(nextButtonTouchUpInside(_:)))
        nextButtonView.addSubview(button)
        
        let del = CustomTextFieldDelegate()
        idTextField.delegate = del
        idTextField.validator = ValidationRegularTextFactory.makeRegularExpression(as: .id)
    }
    
    @objc func nextButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "PrivateInfoViewController", sender: self)
    }
}

