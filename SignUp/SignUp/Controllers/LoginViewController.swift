import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(responseReceived(_:)), name: NotificationName.normalResponseReceived, object: HttpRequestHandler.self)
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
    
    @objc func responseReceived(_ notification: Notification){
        guard let responseBody = notification.userInfo?[HttpResponseKey.responseBodyData] as? Dictionary<String,String> else { return }
        guard let status = responseBody["status"] else { return }
    }
    
}
    }
}
