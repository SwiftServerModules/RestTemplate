//
//  RestTemplate.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public struct RestTemplate: RestOperations {
    public func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) throws -> T {
        fatalError()
    }
    
    public func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String : Any]) throws -> T {
        fatalError()
    }
    
    public func getForObject<T>(url: URL, responseType: T.Type) throws -> T {
        fatalError()
    }
    
    public func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String : Any]) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func getForObject<T>(url: URL, responseType: T.Type) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func headForHeaders(url: String, uriVariables: Any...) throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: String, uriVariables: [String : Any]) throws -> HttpHeaders {
        fatalError()
    }
    
    public func headForHeaders(url: URL) throws -> HttpHeaders {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Codable, uriVariables: Any...) throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Any, uriVariables: [String : Any]) throws -> URL {
        fatalError()
    }
    
    public func postForLocation(url: String, request: Any) throws -> URL {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> T {
        fatalError()
    }
    
    public func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) throws -> T {
        fatalError()
    }
    
    public func postForObject<T>(url: URL, request: Any, responseType: T.Type) throws -> T {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func postForEntity<T>(url: URL, request: Any, responseType: T.Type) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func put(url: String, request: Any, urlVariables: Any...) throws {
        fatalError()
    }
    
    public func put(url: String, request: Any, urlVariables: [String : Any]) throws {
        fatalError()
    }
    
    public func put(url: URL, request: Any) throws {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> T {
        fatalError()
    }
    
    public func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String : Any]) throws -> T {
        fatalError()
    }
    
    public func patchForObject<T>(url: URL, request: Any, responseType: T.Type) throws -> T {
        fatalError()
    }
    
    public func delete(url: String, request: Any, urlVariables: Any...) throws {
        fatalError()
    }
    
    public func delete(url: String, request: Any, urlVariables: [String : Any]) throws {
        fatalError()
    }
    
    public func delete(url: URL, request: Any) throws {
        fatalError()
    }
    
    public func optionsForAllow(url: String, uriVariables: Any...) throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: String, uriVariables: [String : Any]) throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func optionsForAllow(url: URL) throws -> Set<HTTPMethod> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: [String : Any]) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(url: URL, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    public func exchange<T>(requestEntity: HTTPEntity<Any>, responseType: T.Type) throws -> ResponseEntity<T> {
        fatalError()
    }
    
    func doExecute<REQ:Codable,RES:Codable>(url: URL, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES?{
        // create request
        var req = URLRequest(url: url,
                             cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                             timeoutInterval: TimeInterval(60))
        req.httpMethod = method.rawValue
        
        // execute async
        return try await doExecute(request: req,type: responseType)
        
    }
    
    /// Actual network call to endpoint
    /// - Parameters:
    ///   - request: prepared request object with all information about network call
    ///   - type: response type to deserialize object into
    ///   - completion: for async execution
    func doExecute<T:Codable>(request: URLRequest,type: T.Type) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(for: request)
        // check data later
        guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else{
            throw DataError.invalidResponse
        }
        // decode data to swift object
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DataError.invalidData
        }
    }
}

