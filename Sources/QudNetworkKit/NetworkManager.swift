//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

struct NetworkManager {
  let mapper: RequestMapping

  init(mapper: RequestMapping) {
    self.mapper = mapper
  }

  func request
  <
    T: Decodable,
    R: RequestDraft
  >
  (
    _ request: R,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    var urlRequest: URLRequest?
    do {
      urlRequest = try mapper.map(with: request)
    } catch {
      completion(.failure(NetworkError.invalidURL))
    }

    guard let urlRequest = urlRequest else {
      completion(.failure(NetworkError.invalidURL))
      return
    }

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(NetworkError.requestFailed))
        return
      }

      do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedData))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
