import Foundation
import OSLog

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum HttpResponseKey: String{
    case responseBodyData = "responseBodyData"
}

struct NotificationName{
    static let normalResponseReceived = Notification.Name("normalResponseReceived")
}

class HttpRequestHandler{
    
    static let logger = Logger()
    static func sendRequest(data: Data?, url: URL, httpMethod: HttpMethod, completion: @escaping ()->Void){
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard error == nil else {
                self.logger.error("\(error.debugDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                self.logger.error("Could not receive any response or data")
                //네트워크 오류로 인한 로그인 실패 출력
                return
            }
            
            if(response.statusCode >= 400){
                self.logger.debug("detected response with \(response.statusCode) status\nurl : \(url)")
                return
            }
            
            guard let responseBody = try? JSONDecoder().decode(Dictionary<String, String>.self, from: data) else { return }
            NotificationCenter.default.post(name: NotificationName.normalResponseReceived, object: self, userInfo: [HttpResponseKey.responseBodyData:responseBody])
            
        }.resume()
    }
}
