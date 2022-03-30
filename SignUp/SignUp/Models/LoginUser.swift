import Foundation


class LoginUser: CustomStringConvertible, LoginUserProtocol{
    private (set) var id: String?
    private (set) var password: String?
    var description: String{
        let id = self.id == nil ? "" : self.id!
        return "User:\(id)"
    }
    
    init(id: String, password: String){
        self.id = id
        self.password = password
    }
}
