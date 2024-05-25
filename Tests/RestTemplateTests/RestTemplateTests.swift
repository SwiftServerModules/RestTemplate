import XCTest
@testable import RestTemplate

final class RestTemplateTests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
        let appetizerURL = baseURL + "appetizers"
        
        let rt = RestTemplate()
        rt.interceptors = [
            BasicAuthenticationInterceptor(username: "abc", password: "def")]
       
        let res:AppetizerResponse? = try await rt.doExecute(url: URL(string: appetizerURL )!,
                     method: HTTPMethod.GET,
                     body: MockData.sampleAppetizer,
                     responseType: AppetizerResponse.self)

        print(res!)
    }
}
