//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

public protocol RequestDraft {
  associatedtype Response: Decodable

  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var headers: [String: String]? { get }
  var body: Data? { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
