import Foundation

protocol LoginViewDelegate: AnyObject{
    func sendIdAndPasswordInput(id: String, password: String)
    func determiningLoginButtonValidationRequested(id: String, password: String)
}
