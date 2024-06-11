@testable import RestTemplate
import XCTest

final class RestTemplateTests: XCTestCase {
    func testExample() async throws {
        let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
        let appetizerURL = baseURL + "appetizers"
        
        let rt = RestTemplate()
        rt.interceptors = [
            BasicAuthenticationInterceptor(username: "abc", password: "def"),
        ]
        
        let res = try await rt.getForObject(url: appetizerURL, responseType: AppetizerResponse.self)
        
        print(res!)
        XCTAssertEqual(17, res?.request.capacity)
    }
    
    func testResponesExtracter() async throws {
        let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
        let appetizerURL = baseURL + "appetizers"
        
        let rt = RestTemplate()
        let x = try await rt.execute(url: URL(string: appetizerURL)!,
                                       method: .GET,
                                     body: nil as String?, responseType: AppetizerResponse.self)
        print(x!)
    }
    
    func testResponesEntityExtracter() async throws {
        let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
        let appetizerURL = baseURL + "appetizers"
        
        let rt = RestTemplate()
        let x = try await rt.executeForResponseEntity(url: URL(string: appetizerURL)!,
                                       method: .GET,
                                     body: nil as String?, responseType: AppetizerResponse.self)
        print(x)
        XCTAssertEqual(17, x.body??.request.capacity)
    }
}
