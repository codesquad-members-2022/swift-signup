//
//  WelcomeViewController.swift
//  SignUp
//
//  Created by 김한솔 on 2022/03/29.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func registerButtonTouched(_ sender: UIButton) {
        guard let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: RegisterViewController.identifier) else {
            return
        }
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
