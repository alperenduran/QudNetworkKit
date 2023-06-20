//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

public struct QudNetworkKit {
  private let networkManager: NetworkManager
  
  public init() {
    self.networkManager = .init(mapper: RequestMapper())
  }

  public func request<T: Decodable>(_ draft: RequestDraft, response: T.Type) async throws -> T {
    do {
      let data = try await networkManager.request(draft, response: response.self)
      return data
    } catch {
      throw NetworkError.requestFailed
    }
  }
}
