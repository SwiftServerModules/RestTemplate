//
//  RestOperations.swift
//  
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case OPTIONS = "OPTIONS"
    case TRACE = "TRACE"
}

/**
 Interface specifying a basic set of RESTful operations.
 Implemented by ``RestTemplate``
 */
public protocol RestOperations{
    // MARK: - GET
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) async throws -> T
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String:Any]) async throws -> T
    
    func getForObject<T>(url: URL, responseType: T.Type) async throws -> T
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) async throws -> ResponseEntity<T>
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String:Any]) async throws -> ResponseEntity<T>
    
    func getForObject<T>(url: URL, responseType: T.Type) async throws -> ResponseEntity<T>
    
    
    // MARK: - HEAD
    
    func headForHeaders(url: String, uriVariables: Any...) async throws -> HttpHeaders
    
    func headForHeaders(url: String, uriVariables:  [String:Any]) async throws -> HttpHeaders
    
    func headForHeaders(url: URL) async throws -> HttpHeaders
    
    // MARK: - POST
    
    func postForLocation(url: String, request: Codable, uriVariables: Any...) async throws -> URL
    
    func postForLocation(url: String, request: Any, uriVariables: [String:Any]) async throws -> URL
    
    func postForLocation(url: String, request: Any) async throws -> URL
    
    func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> T
    
    func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) async throws -> T
    
    func postForObject<T>(url: URL, request: Any, responseType: T.Type) async throws -> T
    
    func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> ResponseEntity<T>
    
    func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) async throws -> ResponseEntity<T>
    
    func postForEntity<T>(url: URL, request: Any, responseType: T.Type) async throws -> ResponseEntity<T>
    
    // MARK: - PUT
    
    func put(url: String, request: Any, urlVariables: Any...) async throws -> Void
    
    func put(url: String, request: Any, urlVariables:[String:Any]) async throws -> Void
    
    func put(url: URL, request: Any) async throws -> Void
    
    // MARK: - PATCH
    
    func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) async throws -> T
    
    func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) async throws -> T
    
    func patchForObject<T>(url: URL, request: Any, responseType: T.Type) async throws -> T
    
    
    // MARK: - DELETE
    
    func delete(url: String, request: Any, urlVariables: Any...) async throws -> Void
    
    func delete(url: String, request: Any, urlVariables:[String:Any]) async throws -> Void
    
    func delete(url: URL, request: Any) async throws -> Void
    
    // MARK: - OPTIONS
    
    func optionsForAllow(url: String, uriVariables: Any...) async throws -> Set<HTTPMethod>
    
    func optionsForAllow(url: String, uriVariables: [String:Any]) async throws -> Set<HTTPMethod>
    
    func optionsForAllow(url: URL) async throws -> Set<HTTPMethod>
    
    // MARK: - exchange
    
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: Any...) async throws -> ResponseEntity<T>
    
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: [String:Any]) async throws -> ResponseEntity<T>
    
    func exchange<T>(url: URL, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    func exchange<T>(requestEntity: HTTPEntity<Any>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    // MARK: - execute
    
    func doExecute<REQ:Codable,RES:Codable>(url: URL, method: HTTPMethod, body: REQ?, responseType: RES.Type) async throws -> RES?
    
}
