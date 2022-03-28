//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
    }
    
    private func configureSignUpView() {
        setTitle()
    }
    
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        self.navigationItem.titleView = label
    }
    
    
}

