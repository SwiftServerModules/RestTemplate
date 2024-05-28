//
//  RestTemplate.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

//https://stackoverflow.com/questions/51058292/why-cant-we-use-protocol-encodable-as-a-type-in-the-func
extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public class RestTemplate: RestOperations {
    
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    private let jsonEncoder: JSONEncoder = JSONEncoder()
    var interceptors:[ClientHttpRequestInterceptor] = []
    
    public func getForObject<RES:Codable>(url: String, responseType: RES.Type,_ uriVariables: String...) async throws -> RES? {
        return try await execute(url: url, method: .GET, body: nil as String?, responseType: responseType)
    }
    
    public func getForObject<RES:Codable>(url: String, responseType: RES.Type, uriVariables: [String : String]) async throws -> RES? {
        fatalError()
    }
    
    public func getForObject<RES:Codable>(url: URL, responseType: RES.Type) async throws -> RES? {
        fatalError()
    }
    
    public func getForEntity<RES:Codable>(url: String, responseType: RES.Type, uriVariables: Any...) async throws -> ResponseEntity<RES> {
        fatalError()
    }
    
    public func getForEntity<RES:Codable>(url: String, responseType: RES.Type, uriVariables: [String : Any]) async throws -> ResponseEntity<RES> {
        fatalError()
    }
    
    public func getForEntity<RES:Codable>(url: URL, responseType: RES.Type) async throws -> ResponseEntity<RES> {
        fatalError()
    }
    
    public func headForHeaders(url: String, uriVariables: Any...) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: String, uriVariables: [String : Any]) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: URL) async throws -> HttpHeaders {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Codable, uriVariables: Any...) async throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Any, uriVariables: [String : Any]) async throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Any) async throws -> URL {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> T? {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) async throws -> T? {
        fatalError()
    }
    
    public func postForObject<T>(url: URL, request: Any, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: URL, request: Any, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func put(url: String, request: Any, urlVariables: Any...) async throws {
        fatalError()
    }
    
    public func put(url: String, request: Any, urlVariables: [String : Any]) async throws {
        fatalError()
    }
    
    public func put(url: URL, request: Any) async throws {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> T? {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) async throws -> T? {
        fatalError()
    }
    
    public func patchForObject<T>(url: URL, request: Any, responseType: T.Type) async throws -> T? {
        fatalError()
    }
    
    public func delete(url: String, request: Any, urlVariables: Any...) async throws {
        fatalError()
    }
    
    public func delete(url: String, request: Any, urlVariables: [String : Any]) async throws {
        fatalError()
    }
    
    public func delete(url: URL, request: Any) async throws {
        fatalError()
    }
    
    public func optionsForAllow(url: String, uriVariables: Any...) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: String, uriVariables: [String : Any]) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: URL) async throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Any>, responseType: T.Type, uriVariables: Any...) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Any>, responseType: T.Type, uriVariables: [String : Any]) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: URL, method: HTTPMethod, requestEntity: RequestEntity<Any>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
        
    }
    
    public func exchange<T>(requestEntity: RequestEntity<Any>, responseType: T.Type) async throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func execute<REQ:Codable,RES:Codable>(url: String, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES?{
        guard let url = URL(string: url) else { throw RestClientError.invalidData }
        return try await execute(url: url, method: method, body: body, responseType: responseType)
    }
    
    public func execute<REQ:Codable,RES:Codable>(url: URL, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES?{
        // create request
        var req = URLRequest(url: url,
                             cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                             timeoutInterval: TimeInterval(60))

        // set body if present
        if let body = body { req.httpBody = body.toJSONData() }
        
        req.httpMethod = method.rawValue
        
        // running through interceptors
        for interceptor in interceptors {
            interceptor.intercept(&req, nil)
        }
        
        let (data, response) = try await doExecute(request: req)
        
        guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else{
            throw RestClientError.invalidResponse
        }
        // decode data to swift object
        do {
            return try self.jsonDecoder.decode(responseType.self, from: data)
        } catch {
            throw RestClientError.invalidData
        }        
    }
    
    /// Actual network call to endpoint
    /// - Parameters:
    ///   - request: prepared request object with all information about network call
    private func doExecute(request: URLRequest) async throws -> (Data, URLResponse){
        
         return try await URLSession.shared.data(for: request)
    }
}

