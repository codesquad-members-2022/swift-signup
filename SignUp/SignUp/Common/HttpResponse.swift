import Foundation

struct HttpResponse: Codable{
    
    var result: String?
    var status: String?
    
    init(result: String, status: String){
        self.result = result
        self.status = status
    }
}
