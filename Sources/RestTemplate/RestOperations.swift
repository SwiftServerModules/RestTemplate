//
//  RestOperations.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case HEAD
    case POST
    case PUT
    case PATCH
    case DELETE
    case OPTIONS
    case TRACE
}

/**
 Interface specifying a basic set of RESTful operations.
 Implemented by ``RestTemplate``
 */
public protocol RestOperations {
    // MARK: - GET
    
    func getForObject<RES: Codable>(url: String, responseType: RES.Type) async throws -> RES?
    
    func getForObject<RES: Codable>(url: URL, responseType: RES.Type) async throws -> RES?
    
    func getForEntity<RES: Codable>(url: String, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    func getForEntity<RES: Codable>(url: URL, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    // MARK: - HEAD
    
    func headForHeaders(url: String) async throws -> HttpHeaders
    
    func headForHeaders(url: URL) async throws -> HttpHeaders
    
    // MARK: - POST
    
    func postForLocation(url: String, request: Codable?) async throws -> URL
    
    func postForObject<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> T?
    
    func postForObject<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> T?
    
    func postForEntity<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?>
    
    func postForEntity<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?>
    
    // MARK: - PUT
    
    func put(url: String, request: Codable?) async throws -> Void
    
    func put(url: URL, request: Codable?) async throws -> Void
    
    // MARK: - PATCH
    
    func patchForObject<T>(url: String, request: Codable?, responseType: T.Type) async throws -> T?
    
    func patchForObject<T>(url: URL, request: Codable?, responseType: T.Type) async throws -> T?
    
    // MARK: - DELETE
    
    func delete(url: String, request: Codable?) async throws -> Void
    
    func delete(url: URL, request: Codable?) async throws -> Void
    
    // MARK: - OPTIONS
    
    func optionsForAllow(url: String) async throws -> Set<HTTPMethod>
    
    func optionsForAllow(url: URL) async throws -> Set<HTTPMethod>
    
    // MARK: - exchange
    
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    func exchange<T>(url: URL, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    func exchange<T>(requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    // MARK: - execute
    
    func execute<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES?
    
    func execute<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES?
    
    func executeForResponseEntity<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    func executeForResponseEntity<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?>
}
