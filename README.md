# QudNetworkKit

QudNetworkKit is a networking library that provides a simplified interface for making network requests in Swift. It encapsulates the underlying network operations and offers convenient methods for performing API requests and handling responses.

## Features:
- Modular Design: QudNetworkKit follows a modular design, making it easy to integrate into any Swift project.
- Async/Await Support: Built using Swift's async/await concurrency model, enabling clean and efficient asynchronous programming.
- Error Handling: Provides comprehensive error handling, allowing you to handle and recover from network-related errors.

## Getting Started:

### Installation:
To use QudNetworkKit in your project, follow these steps:

Add the QudNetworkKit package as a dependency in your project. You can do this by adding the following line to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/alperenduran/QudNetworkKit.git", from: "1.0.0")
]
```

Import the QudNetworkKit module in your source files:

```swift
import QudNetworkKit
```

Usage:
To use QudNetworkKit in your code, follow these steps:

Create an instance of QudNetworkKit:

```swift
let networkKit = QudNetworkKit()

// Make a network request by calling the request method:

do {
    let user: User = try await networkKit.request(userRequestDraft)
    // Handle the user response
} catch {
    // Handle the error
}
```

In the example above, userRequestDraft represents an instance of a request draft object that conforms to the RequestDraft protocol. The request method is called with the request draft, and it returns the decoded response object of type User (assuming User is a decodable type).

## Customization:

### RequestDraft Protocol:
The QudNetworkKit expects request drafts to conform to the RequestDraft protocol. This protocol allows you to define the necessary properties and methods required for making API requests. You can conform to this protocol in your custom request draft types.

```swift
public protocol RequestDraft {
  associatedtype Response: Decodable

  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var headers: [String: String]? { get }
  var body: Data? { get }
}
```

## Contributing:

Contributions to QudNetworkKit are welcome! If you find any issues or have suggestions for improvements, please feel free to submit a pull request or open an issue on the GitHub repository.

## License:

QudNetworkKit is released under the MIT License. See the LICENSE file for more information.

