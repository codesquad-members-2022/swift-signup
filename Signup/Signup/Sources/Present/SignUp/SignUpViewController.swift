//
//  ViewController.swift
//  Signup
//
//  Created by seongha shin on 2022/03/28.
//

import UIKit

class SignUpViewController: UIViewController {

    let model = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
    }
    
    private func bind() {
        
//        model.action.nextButtonTapped.send()
//        model.action.userIdEntered.send("idididid")
//        model.action.passwordEntered.send("password")
        
        model.action.nextButtonTapped.send()
        
        model.action.userIdEntered.send("****")
        model.action.passwordEntered.send("password")
        model.action.userIdEntered.send("idididid1234")
//        model.action.userIdEntered.send("idididid123")
//        model.action.passwordEntered.send("password113")
    }
    
    private func layout() {
        
    }
}

