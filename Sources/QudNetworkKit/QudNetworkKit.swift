//
//  Created by Alperen Duran on 14.06.23.
//

import Foundation

public struct QudNetworkKit {
  private let networkManager: NetworkManager

  public init() {
    self.networkManager = .init(mapper: RequestMapper())
  }

  public func request<T: Decodable>(
    _ draft: any RequestDraft,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    networkManager.request(draft, completion: completion)
  }
}
