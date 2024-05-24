//
//  RestOperations.swift
//  
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

public class ResponseEntity<T>: HTTPEntity<T>{
    
}

public class HttpHeaders{
    
}

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

public protocol RestOperations{
    // MARK: - GET
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) throws -> T
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String:Any]) throws -> T
    
    func getForObject<T>(url: URL, responseType: T.Type) throws -> T
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T>
    
    func getForObject<T>(url: String, responseType: T.Type, uriVariables: [String:Any]) throws -> ResponseEntity<T>
    
    func getForObject<T>(url: URL, responseType: T.Type) throws -> ResponseEntity<T>
    
    
    // MARK: - HEAD
    
    func headForHeaders(url: String, uriVariables: Any...) throws -> HttpHeaders
    
    func headForHeaders(url: String, uriVariables:  [String:Any]) throws -> HttpHeaders
    
    func headForHeaders(url: URL) throws -> HttpHeaders
    
    // MARK: - POST
    
    func postForLocation(url: String, request: Codable, uriVariables: Any...) throws -> URL
    
    func postForLocation(url: String, request: Any, uriVariables: [String:Any]) throws -> URL
    
    func postForLocation(url: String, request: Any) throws -> URL
    
    func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> T
    
    func postForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) throws -> T
    
    func postForObject<T>(url: URL, request: Any, responseType: T.Type) throws -> T
    
    func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T>
    
    func postForEntity<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) throws -> ResponseEntity<T>
    
    func postForEntity<T>(url: URL, request: Any, responseType: T.Type) throws -> ResponseEntity<T>
    
    // MARK: - PUT
    
    func put(url: String, request: Any, urlVariables: Any...) throws -> Void
    
    func put(url: String, request: Any, urlVariables:[String:Any]) throws -> Void
    
    func put(url: URL, request: Any) throws -> Void
    
    // MARK: - PATCH
    
    func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: Any...) throws -> T
    
    func patchForObject<T>(url: String, request: Any, responseType: T.Type, uriVariables: [String:Any]) throws -> T
    
    func patchForObject<T>(url: URL, request: Any, responseType: T.Type) throws -> T
    
    
    // MARK: - DELETE
    
    func delete(url: String, request: Any, urlVariables: Any...) throws -> Void
    
    func delete(url: String, request: Any, urlVariables:[String:Any]) throws -> Void
    
    func delete(url: URL, request: Any) throws -> Void
    
    // MARK: - OPTIONS
    
    func optionsForAllow(url: String, uriVariables: Any...) throws -> Set<HTTPMethod>
    
    func optionsForAllow(url: String, uriVariables: [String:Any]) throws -> Set<HTTPMethod>
    
    func optionsForAllow(url: URL) throws -> Set<HTTPMethod>
    
    // MARK: - exchange
    
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: Any...) throws -> ResponseEntity<T>
    
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type, uriVariables: [String:Any]) throws -> ResponseEntity<T>
    
    func exchange<T>(url: URL, method: HTTPMethod, requestEntity: HTTPEntity<Any>, responseType: T.Type) throws -> ResponseEntity<T>
    
    func exchange<T>(requestEntity: HTTPEntity<Any>, responseType: T.Type) throws -> ResponseEntity<T>
    
    // MARK: - execute
    
}
