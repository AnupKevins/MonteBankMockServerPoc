import Foundation
import Alamofire

struct RequestModel: Requestable {
    
    typealias ResponseType = WelcomeElement

    private var endpoint: String

    init(endpoint: String) {
        self.endpoint = endpoint
    }

    var method: HTTPMethod {
        return .get
    }
    
    var baseUrl: URL {
        return URL(string: "\(UrlConstant.HOST)\(endpoint)")!
    }
}
