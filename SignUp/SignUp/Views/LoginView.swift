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
        self.checkLoginButtonValidation()
    }
    
    @IBAction func passwordInputEditingChanged(_ sender: Any) {
        self.checkLoginButtonValidation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    private func checkLoginButtonValidation(){
        guard let idInput = self.idTextField.text else { return }
        guard let passwordInput = self.passwordTextField.text else { return }
        if(isInputValid(id: idInput, password: passwordInput)){
            validateLoginButton()
        }else{
            invalidateLoginButton()
        }
        
        func isInputValid(id: String, password: String)-> Bool{
            if(id.count <= 0 || password.count <= 0){
                return false
            }
            return true
        }
    }
    
    private func invalidateLoginButton(){
        guard let loginButton = self.loginButton else { return }
        loginButton.isEnabled = false
    }
    
    private func validateLoginButton(){
        guard let loginButton = self.loginButton else { return }
        loginButton.isEnabled = true
    }

}
