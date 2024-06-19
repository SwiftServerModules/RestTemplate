//
//  RestTemplate.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

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
    
    public func headForHeaders(url: String) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: URL) async throws -> HttpHeaders {
        fatalError()
    }
    
    // MARK: - POST
    
    public func postForLocation(url: String, request: Codable?) async throws -> URL {
        fatalError()
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
        fatalError()
    }
    
    public func put(url: URL, request: Codable?) async throws {
        fatalError()
    }
    
    // MARK: - PATCH
    
    public func patchForObject<T>(url: String, request: Codable?, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    public func patchForObject<T>(url: URL, request: Codable?, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    // MARK: - DELETE
    
    public func delete(url: String, request: Codable?) async throws {
        fatalError()
    }
    
    public func delete(url: URL, request: Codable?) async throws {
        fatalError()
    }
    
    // MARK: - OPTIONS
    
    public func optionsForAllow(url: String) async throws -> [HTTPMethod] {
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await optionsForAllow(url: url)
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
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await execute(url: url, method: method, body: body, responseType: responseType)
    }
    
    public func execute<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES? {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    public func executeForResponseEntity<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await executeForResponseEntity(url: url, method: method, body: body, responseType: responseType)
    }
    
    public func executeForResponseEntity<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    // MARK: - internal
    
    /// Actual network call to endpoint
    /// - Parameters:
    ///   - request: prepared request object with all information about network call
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
}
