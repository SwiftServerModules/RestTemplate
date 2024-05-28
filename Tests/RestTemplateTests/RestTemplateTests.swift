import XCTest
@testable import RestTemplate

final class RestTemplateTests: XCTestCase {
    func testExample() async throws {
        
        let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
        let appetizerURL = baseURL + "appetizers"
        
        let rt = RestTemplate()
        rt.interceptors = [
            BasicAuthenticationInterceptor(username: "abc", password: "def")]
        
        let res = try await rt.getForObject(url: appetizerURL, responseType: AppetizerResponse.self)
        
        print(res!)
        XCTAssertEqual(17, res?.request.capacity)
    }
}
