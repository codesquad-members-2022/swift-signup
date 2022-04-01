import Foundation

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
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
    
    static func sendRequest(data: Data?, url: URL, httpMethod: HttpMethod, completion: @escaping ()->Void){
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
    static func sendRequest(data: Data?, url: URL, httpMethod: HttpMethod, completion: @escaping (_ result: Result<Data,Error>)->Void){
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error{
                completion(.failure(HttpError.normalError(error: error)))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(HttpError.dataNotReceivedError))
                return
            }

            if(response.statusCode >= 400){
                completion(.failure(HttpError.requestError))
                return
            }

            completion(.success(data))
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
