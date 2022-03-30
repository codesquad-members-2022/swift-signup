import Foundation

protocol LoginViewDelegate: AnyObject{
    func sendIdAndPasswordInput(id: String, password: String)
}
