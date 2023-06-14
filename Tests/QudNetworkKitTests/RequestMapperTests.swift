import XCTest
@testable import QudNetworkKit

final class RequestMapperTests: XCTestCase {
  var sut: RequestMapping!

  override func setUp() {
    self.sut = RequestMapper()
    super.setUp()
  }

  override func tearDown() {
    self.sut = nil
    super.tearDown()
  }

  func testMapsCorrectly() throws {
    let draft = MockRequest()
    let result = try! sut.map(with: draft)

    XCTAssertEqual(
      result.url?.absoluteString,
      "https://api.api-ninjas.com/v1/loremipsum?paragraphs=5"
    )
  }
}

struct MockRequest: RequestDraft {
  let count: Int = 5

  typealias Response = MockResponse

  var baseURL: URL {
    URL(string: "https://api.api-ninjas.com")!
  }

  var path: String {
    "/v1/loremipsum"
  }

  var method: HTTPMethod {
    .get
  }

  var parameters: [String : Any]? {
    [
      "paragraphs": count
    ]
  }

  var headers: [String : String]? {
    nil
  }

  var body: Data? {
    nil
  }
}

struct MockResponse: Decodable {
  let text: String
}
