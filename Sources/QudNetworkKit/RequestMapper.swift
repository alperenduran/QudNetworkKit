//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

protocol RequestMapping {
  func map(with draft: any RequestDraft) throws -> URLRequest
}

struct RequestMapper: RequestMapping {
  func map(with draft: any RequestDraft) throws -> URLRequest {
    var urlComponents = URLComponents(url: draft.baseURL, resolvingAgainstBaseURL: false)
    urlComponents?.path = draft.path
    urlComponents?.queryItems = draft.parameters?.map { key, value in
      URLQueryItem(name: key, value: "\(value)")
    }

    guard let url = urlComponents?.url else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = draft.method.rawValue
    request.allHTTPHeaderFields = draft.headers
    request.httpBody = draft.body

    return request
  }
}
