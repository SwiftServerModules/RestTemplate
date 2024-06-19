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
    
    func testExampleUsers() async throws {
        let baseURL = "http://localhost:8080/api/v1/user"
        
        let rt = RestTemplate()
        
        let res = try await rt.getForObject(url: baseURL, responseType: [User].self)
        
        print(res!)
    }
    
    func testAddUsers() async throws {
        let baseURL = "http://localhost:8080/api/v1/user"
        let user = User(id: 1, username: "spiderman", age: 19)
        
        let rt = RestTemplate()
        
        let res = try await rt.postForObject(url: baseURL, request: user, responseType: User.self)
        XCTAssertEqual(user, res)
        print(res!)
    }
    
    func testAddUsers2() async throws {
        let baseURL = "http://localhost:8080/api/v1/user"
        guard let url = URL(string: baseURL) else { throw RestClientError.invalidData }
        let user = User(id: 1, username: "spiderman", age: 19)
        
        let rt = RestTemplate()
        
        let res = try await rt.execute(url: url, method: .POST, body: user, responseType: User.self)
        XCTAssertEqual(user, res)
        print(res!)
    }
}
