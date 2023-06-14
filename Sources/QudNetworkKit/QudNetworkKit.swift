//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

public struct QudNetworkKit {
  private let networkManager: NetworkManager
  
  public init() {
    self.networkManager = .init(mapper: RequestMapper())
  }

  public func request<T: Decodable>(_ draft: any RequestDraft) async throws -> T {
    do {
      let data: T = try await networkManager.request(draft)
      return data
    } catch {
      throw NetworkError.requestFailed
    }
  }
}
