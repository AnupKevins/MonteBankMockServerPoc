import Foundation
import Alamofire

class NetworkServiceManager {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func makeServiceCall<T: Requestable>(
        req: T,
        //completionHandler: @escaping (Result<[T.ResponseType]>) -> Void
        completionHandler: @escaping (Result<[String: Any]>) -> Void
    ) {
        AF.request(req.baseUrl, method: req.method, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            
           // guard let strongSelf = self else { return }
            
            guard let data = response.data else {
                completionHandler(
                    Result.failure(
                        AppError.dataError(
                            description: "Response is empty"
                        )
                    )
                )
                return
            }
            
            if let result = response.value as? [String: Any] {
                print(result)
                
                completionHandler(.success(result))
                
//                do {
//                    let object = try self.decoder
//                        .decode(
//                            [T.ResponseType].self,
//                            from: data
//                    )
//                    completionHandler(Result.success(object))
//                } catch let error {
//                    completionHandler(Result.failure(error))
//                }
            }
        })
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol Requestable {
    associatedtype ResponseType: Codable
    var method: HTTPMethod { get }
    var baseUrl: URL { get }
}

enum AppError: LocalizedError {
    case unknownError
    case networkError(status: Int, description: String)
    case dataError(description: String)

    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknown Error has Occurred"
        case .networkError(status: let status, description: let desc):
            return "\(status): \(desc)"
        case .dataError(description: let desc):
            return desc
        }
    }
}
