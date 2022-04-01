import Foundation

protocol HttpResponseHandlable{
    func handleSuccess(data: Data)
    func handleFailure(error: Error)
}
