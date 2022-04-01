import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
}

extension LoginViewController: LoginViewDelegate{
    
    func sendIdAndPasswordInput(id: String, password: String) {
        let loginUser = LoginUser(id: id, password: password)
        let jsonData = try? JSONEncoder().encode(loginUser)
        if let url = URL(string: "https://api.codesquad.kr/signup"){
            HttpRequestHandler.sendRequest(data: jsonData, url: url, httpMethod: HttpMethod.post){}
        }
    }
    
    func determiningLoginButtonValidationRequested(id: String, password: String) {
        if(isInputValid(id: id, password: password)){
            self.loginView.validateLoginButton()
        }else{
            self.loginView.invalidateLoginButton()
        }
        
        func isInputValid(id: String, password: String)-> Bool{
            if(id.count <= 0 || password.count <= 0){
                return false
            }
            return true
        }
    }
    
        guard let status = responseBody["status"] else { return }
        
        var alertMessage: String = ""
        if(status == "409"){
            alertMessage = "로그인 성공"
        }else{
            alertMessage = "로그인 실패"
        }
        self.presentAlert(title: "로그인 테스트", message: alertMessage)
    }
    
}

extension LoginViewController: AlertPresentable{
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        alert.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
