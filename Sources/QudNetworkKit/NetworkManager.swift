//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

struct NetworkManager {
  let mapper: RequestMapping
  
  init(mapper: RequestMapping) {
    self.mapper = mapper
  }
  
  func request<T: Decodable, R: RequestDraft>(_ request: R) async throws -> T {
    var urlRequest: URLRequest?
    do {
      urlRequest = try mapper.map(with: request)
    } catch {
      throw NetworkError.invalidURL
    }
    
    guard let urlRequest = urlRequest else {
      throw NetworkError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    
    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      throw error
    }
  }
}
