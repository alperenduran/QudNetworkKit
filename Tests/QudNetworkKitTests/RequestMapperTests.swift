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
    let network = QudNetworkKit()
    let expectation = XCTestExpectation(description: "Async function expectation")

    XCTAssertEqual(
      result.url?.absoluteString,
      "https://api.api-ninjas.com/v1/loremipsum?paragraphs=1"
    )

    Task {
      do {
        let result = try await network.request(MockRequest(), response: MockResponse.self)
        XCTAssertNotNil(result.text)
        expectation.fulfill()
      } catch {
        XCTFail("Error: \(error)")
      }
    }

    wait(for: [expectation], timeout: 10)
  }
}

struct MockRequest: RequestDraft {
  let count: Int = 1

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
    ["X-Api-Key": "addyourtoken"]
  }

  var body: Data? {
    nil
  }
}

struct MockResponse: Decodable {
  let text: String
}
