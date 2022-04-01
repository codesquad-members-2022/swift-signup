import Foundation

enum HttpMethod: CustomStringConvertible{
    case get
    case post
    case put
    
    var description: String{
        switch self{
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        }
    }
}

enum HttpError: Error, CustomStringConvertible{
    case normalError(error: Error)
    case dataNotReceivedError
    case requestError
    
    var description: String{
        switch self {
        case .normalError(let error):
            return error.localizedDescription
        case .dataNotReceivedError:
            return "data not received"
        case .requestError:
            return "client request error"
        }
    }
}

class HttpRequestHandler{
    
    static func generateURLRequest(data: Data?, url: URL, httpMethod: HttpMethod) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        return request
    }
    
    static func sendRequest(data: Data?, url: URL, httpMethod: HttpMethod, target: HttpResponseHandlable) {
        let request = generateURLRequest(data: data, url: url, httpMethod: httpMethod)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error{
                self.handleResponse(target: target, result: .failure(HttpError.normalError(error: error)))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                self.handleResponse(target: target, result: .failure(HttpError.dataNotReceivedError))
                return
            }

            if(response.statusCode >= 400){
                self.handleResponse(target: target, result: .failure(HttpError.requestError))
                return
            }
            
            self.handleResponse(target: target, result: .success(data))
        }.resume()
    }

    static func handleResponse(target: HttpResponseHandlable, result: Result<Data, Error>){
        switch result{
        case .success(let data):
            target.handleSuccess(data: data)
        case .failure(let error):
            target.handleFailure(error: error)
        }
    }
}
