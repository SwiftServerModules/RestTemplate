import XCTest
@testable import RestTemplate

final class RestTemplateTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RestTemplate().text, "Hello, World!")
    }
}
