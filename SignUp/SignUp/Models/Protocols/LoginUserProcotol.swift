import Foundation

protocol LoginUserProtocol: Codable{
    var id: String? { get }
    var password: String? { get }
}
