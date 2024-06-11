//
//  RestTemplate.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

// https://stackoverflow.com/questions/51058292/why-cant-we-use-protocol-encodable-as-a-type-in-the-func
extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public class RestTemplate: RestOperations {
    private let jsonDecoder: JSONDecoder = .init()
    private let jsonEncoder: JSONEncoder = .init()
    private let resposeExtracter: ResponseExtractor = .init()
    
    var interceptors: [ClientHttpRequestInterceptor] = []
    
    public func getForObject<RES: Codable>(url: String, responseType: RES.Type, _ uriVariables: String...) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForObject<RES: Codable>(url: String, responseType: RES.Type, uriVariables: [String: String]) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForObject<RES: Codable>(url: URL, responseType: RES.Type) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForEntity<RES: Codable>(url: String, responseType: RES.Type, _ uriVariables: String...) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForEntity<RES: Codable>(url: String, responseType: RES.Type, uriVariables: [String: String]) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForEntity<RES: Codable>(url: URL, responseType: RES.Type) async throws -> ResponseEntity<RES?> {
        return try await executeForResponseEntity(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func headForHeaders(url: String, _ uriVariables: String...) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: String, uriVariables: [String: String]) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: URL) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Codable?, _ uriVariables: String...) async throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Codable?, uriVariables: [String: String]) async throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Codable?) async throws -> URL {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Codable?, responseType: T.Type, _ uriVariables: String...) async throws -> T? {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Codable?, responseType: T.Type, uriVariables: [String: String]) async throws -> T? {
        fatalError()
    }
    
    public func postForObject<T>(url: URL, request: Codable?, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Codable?, responseType: T.Type, _ uriVariables: String...) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Codable?, responseType: T.Type, uriVariables: [String: String]) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: URL, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func put(url: String, request: Codable?, _ urlVariables: String...) async throws {
        fatalError()
    }
    
    public func put(url: String, request: Codable?, urlVariables: [String: String]) async throws {
        fatalError()
    }
    
    public func put(url: URL, request: Codable?) async throws {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Codable?, responseType: T.Type, _ uriVariables: String...) async throws -> T? {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Codable?, responseType: T.Type, uriVariables: [String: String]) async throws -> T? {
        fatalError()
    }
    
    public func patchForObject<T>(url: URL, request: Codable?, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    public func delete(url: String, request: Codable?, _ urlVariables: String...) async throws {
        fatalError()
    }
    
    public func delete(url: String, request: Codable?, urlVariables: [String: String]) async throws {
        fatalError()
    }
    
    public func delete(url: URL, request: Codable?) async throws {
        fatalError()
    }
    
    public func optionsForAllow(url: String, _ uriVariables: String...) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: String, uriVariables: [String: String]) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: URL) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type, _ uriVariables: String...) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type, uriVariables: [String: String]) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: URL, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func execute<REQ: Codable, RES: Codable>(url: String, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES? {
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await execute(url: url, method: method, body: body, responseType: responseType)
    }
    
    public func execute<REQ: Codable, RES: Codable>(url: URL, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES? {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    public func executeForResponseEntity<REQ, RES>(url: String, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> ResponseEntity<RES?> where REQ: Decodable, REQ: Encodable, RES: Decodable, RES: Encodable {
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await executeForResponseEntity(url: url, method: method, body: body, responseType: responseType)
    }
    
    public func executeForResponseEntity<REQ, RES>(url: URL, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> ResponseEntity<RES?> where REQ: Decodable, REQ: Encodable, RES: Decodable, RES: Encodable {
        let (data, response) = try await doExecute(url: url, method: method, body: body)
        
        return try resposeExtracter.extractData(response: response, data: data, responseType: responseType)
    }
    
    /// Actual network call to endpoint
    /// - Parameters:
    ///   - request: prepared request object with all information about network call
    private func doExecute<REQ: Codable>(url: URL, method: HTTPMethod, body: REQ?) async throws -> (Data, HTTPURLResponse) {
        // create request
        var request = URLRequest(url: url,
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                                 timeoutInterval: TimeInterval(60))

        // set body if present
        if let body = body { request.httpBody = body.toJSONData() }
        
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
