//
//  RestTemplate.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation



/// async REST client to perform HTTP requests, exposing a simple, template method API over underlying HTTP client  URLSession. works with all apple platforms as of now, linux and windows support coming soon.
///
/// Use as below
/// > Important: Requires all request and response class/structs to conform `Codeable`,`Encodable` or `Decodable`
/// ```swift
/// let rt = RestTemplate()
/// let user: User = try await rt.getForObject(url: "https://example.com/api/user/1", responseType: User.self)
/// ```
/// You can add interceptors to modify or log request before execution. add interceptors as below, they are run as provided in array. see ``BasicAuthenticationInterceptor``
/// ```swift
/// rt.interceptors = [
/// BasicAuthenticationInterceptor(username: "abc", password: "def"),
/// ]
/// ```
@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public class RestTemplate: RestOperations {
    private let jsonDecoder: JSONDecoder = .init()
    private let jsonEncoder: JSONEncoder = .init()
    private let resposeExtracter: ResponseExtractor = .init()
    
    var interceptors: [ClientHttpRequestInterceptor] = []
    
    // MARK: - GET
    
    public func getForObject<RES: Codable>(url: String, responseType: RES.Type) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForObject<RES: Codable>(url: URL, responseType: RES.Type) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForEntity<RES: Codable>(url: String, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForEntity<RES: Codable>(url: URL, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }

    // MARK: - HEAD
    
    public func headForHeaders(url: String) async throws -> [String: String] {
        return try await headForHeaders(url: createUrl(url))
    }
    
    public func headForHeaders(url: URL) async throws -> [String: String] {
        let (_, response) = try await doExecute(url: url, method: .HEAD, body: nil as String?)
        let headers = response.allHeaderFields.map { ($0 as! String, $1 as! String) }
        return Dictionary(uniqueKeysWithValues: headers)
    }
    
    // MARK: - POST
    
    public func postForLocation(url: String, request: Codable?) async throws -> URL? {
        let (_, response) = try await doExecute(url: createUrl(url), method: .POST, body: request)
        guard let location = response.value(forHTTPHeaderField: "Location") else { return URL(string: "") }
        return URL(string: location)
    }
    
    public func postForObject<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> T? {
        return try await execute(url: url, method: .POST, body: request, responseType: responseType)
    }
    
    public func postForObject<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> T? {
        return try await execute(url: url, method: .POST, body: request, responseType: responseType)
    }
    
    public func postForEntity<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?> {
        return try await executeForResponseEntity(url: url, method: .POST, body: request, responseType: responseType)
    }
    
    public func postForEntity<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?> {
        return try await executeForResponseEntity(url: url, method: .POST, body: request, responseType: responseType)
    }
    
    // MARK: - PUT
    
    public func put(url: String, request: Codable?) async throws {
        return try await put(url: createUrl(url), request: request)
    }
    
    public func put(url: URL, request: Codable?) async throws {
        let _ = try await doExecute(url: url, method: .PUT, body: request)
    }
    
    // MARK: - PATCH
    
    public func patchForObject<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> T? {
        return try await patchForObject(url: createUrl(url), request: request, responseType: responseType)
    }
    
    public func patchForObject<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> T? {
        return try await execute(url: url, method: .PATCH, body: request, responseType: responseType)
    }
    
    // MARK: - DELETE
    
    public func delete(url: String) async throws {
        return try await delete(url: createUrl(url))
    }
    
    public func delete(url: URL) async throws {
        let _ = try await doExecute(url: url, method: .DELETE, body: nil as String?)
    }
    
    // MARK: - OPTIONS
    
    public func optionsForAllow(url: String) async throws -> [HTTPMethod] {
        return try await optionsForAllow(url: createUrl(url))
    }
    
    public func optionsForAllow(url: URL) async throws -> [HTTPMethod] {
        let (_, response) = try await doExecute(url: url, method: .OPTIONS, body: nil as String?)
        let value = response.value(forHTTPHeaderField: HttpHeaders.ALLOW)
        
        guard let value = value else { return [] }
        return value.components(separatedBy: ",").map { HTTPMethod.valueOf(method: $0) }
    }
    
    // MARK: - exchange
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: URL, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    // MARK: - execute
    
    public func execute<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES? {
        return try await execute(url: createUrl(url), method: method, body: body, responseType: responseType)
    }
    
    public func execute<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES? {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    public func executeForResponseEntity<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: createUrl(url), method: method, body: body, responseType: responseType)
    }
    
    public func executeForResponseEntity<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    // MARK: - internal
    
    
    /// Does the actual call to endpoint using URLSession(hence only compatible with Apple platform as on now)
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - body: body to be sent with request (may be null)
    /// - Returns: Data and HTTPURLResponse to process later
    private func doExecute(url: URL, method: HTTPMethod, body: Codable?) async throws -> (Data, HTTPURLResponse) {
        // create request
        var request = URLRequest(url: url,
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                                 timeoutInterval: TimeInterval(60))

        // set body if present
        if let body = body { request.httpBody = body.toJSONData()
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpMethod = method.rawValue
        
        // running through interceptors
        for interceptor in interceptors {
            interceptor.intercept(&request, nil)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
            throw RestClientError.invalidResponse
        }
        
        return (data, response)
    }
    
    /// A little helper method to convert string url to URL object
    /// - Parameter url: url in String
    /// - Returns: the URL object
    private func createUrl(_ url: String) throws -> URL {
        guard let url = URL(string: url) else { throw RestClientError.invalidUrl }
        return url
    }
}
