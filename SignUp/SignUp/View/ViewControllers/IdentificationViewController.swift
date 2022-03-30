//
//  IdentificationViewController.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import UIKit

class IdentificationViewController: UIViewController {
    
    @IBOutlet weak var nextButtonView: UIView!
    
    private var idTextFieldDelegate: ValidateTextFieldDelegate?
    @IBOutlet weak var idTextField: CustomTextField! {
        didSet {
            self.idTextFieldDelegate = ValidateTextFieldDelegate(delegate: idTextField)
            idTextField.delegate = self.idTextFieldDelegate
            idTextField.validator = ValidationRegularText(as: .id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = CustomSegueButton(with: nextButtonView.bounds, as: "다음", using: #selector(nextButtonTouchUpInside(_:)))
        nextButtonView.addSubview(button)
    }
    
    @objc func nextButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "PrivateInfoViewController", sender: self)
    }
}

