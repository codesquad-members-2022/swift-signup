import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var delegate: LoginViewDelegate?
    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        guard let idInput = self.idTextField.text else { return }
        guard let passwordInput = self.passwordTextField.text else { return }
        self.delegate?.sendIdAndPasswordInput(id: idInput, password: passwordInput)
    }

    @IBAction func idInputEditingChanged(_ sender: UITextField) {
        guard let idInput = self.idTextField.text else { return }
        guard let passwordInput = self.passwordTextField.text else { return }
        self.delegate?.determiningLoginButtonValidationRequested(id: idInput, password: passwordInput)
    }
    
    @IBAction func passwordInputEditingChanged(_ sender: Any) {
        guard let idInput = self.idTextField.text else { return }
        guard let passwordInput = self.passwordTextField.text else { return }
        self.delegate?.determiningLoginButtonValidationRequested(id: idInput, password: passwordInput)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    func invalidateLoginButton(){
        guard let loginButton = self.loginButton else { return }
        loginButton.isEnabled = false
    }
    
    func validateLoginButton(){
        guard let loginButton = self.loginButton else { return }
        loginButton.isEnabled = true
    }

}
