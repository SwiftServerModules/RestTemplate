//
//  RestOperations.swift
//
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation


/// Interface specifying a basic set of RESTful operations.
///
/// Implemented by ``RestTemplate``
public protocol RestOperations {
    // MARK: - GET
    
    /// Retrieve a representation by doing a GET on the specified URL.
    /// - Parameters:
    ///   - url: the URL
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func getForObject<RES: Codable>(url: String, responseType: RES.Type) async throws -> RES?
    
    /// Retrieve a representation by doing a GET on the specified URL.
    /// - Parameters:
    ///   - url: the URL
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func getForObject<RES: Codable>(url: URL, responseType: RES.Type) async throws -> RES?
    
    /// Retrieve an entity by doing a GET on the specified URL.
    /// The response is converted and stored in a  ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func getForEntity<RES: Codable>(url: String, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    /// Retrieve an entity by doing a GET on the specified URL.
    /// The response is converted and stored in a  ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func getForEntity<RES: Codable>(url: URL, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    // MARK: - HEAD
    
    /// Retrieve all headers of the resource specified by the URL.
    /// - Parameter url: the URL
    /// - Returns: all HTTP headers of that resource
    func headForHeaders(url: String) async throws -> [String: String]
    
    /// Retrieve all headers of the resource specified by the URL.
    /// - Parameter url: the URL
    /// - Returns: all HTTP headers of that resource
    func headForHeaders(url: URL) async throws -> [String: String]
    
    // MARK: - POST
    
    /// Create a new resource by POSTing the given object to the URI template, and return the value of `Location` Header.
    /// This header typically indicates where the new resource is stored.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be POSTed (maybe null)
    /// - Returns: the URL value for the Location header
    func postForLocation(url: String, request: Codable?) async throws -> URL?
    
    /// Create a new resource by POSTing the given object to the URI and return the representation found in the response.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be POSTed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func postForObject<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> T?
    
    /// Create a new resource by POSTing the given object to the URI and return the representation found in the response.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be POSTed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func postForObject<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> T?
    
    /// Create a new resource by POSTing the given object to the URI.
    /// The response is converted and stored in a  ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be POSTed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func postForEntity<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?>
    
    /// Create a new resource by POSTing the given object to the URI.
    /// The response is converted and stored in a  ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be POSTed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func postForEntity<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> ResponseEntity<T?>
    
    // MARK: - PUT
    
    /// Create or update a resource by PUTting the given object to the URI.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be PUT (may be null)
    /// - Returns: nothing
    func put(url: String, request: Codable?) async throws -> Void
    
    /// Create or update a resource by PUTting the given object to the URI.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the Object to be PUT (may be null)
    /// - Returns: nothing
    func put(url: URL, request: Codable?) async throws -> Void
    
    // MARK: - PATCH
    
    /// Update a resource by PATCHing the given object to the URI and return the representation found in the response.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the object to be PATCHed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func patchForObject<T: Codable>(url: String, request: Codable?, responseType: T.Type) async throws -> T?
    
    /// Update a resource by PATCHing the given object to the URI and return the representation found in the response.
    /// - Parameters:
    ///   - url: the URL
    ///   - request: the object to be PATCHed (may be null)
    ///   - responseType: the type of the return value
    /// - Returns: the converted object
    func patchForObject<T: Codable>(url: URL, request: Codable?, responseType: T.Type) async throws -> T?
    
    // MARK: - DELETE
    
    /// Delete the resources at the specified URI.
    /// - Parameter url: the URL
    /// - Returns: nothing
    func delete(url: String) async throws -> Void
    
    /// Delete the resources at the specified URI.
    /// - Parameter url: the URL
    /// - Returns: nothing
    func delete(url: URL) async throws -> Void
    
    // MARK: - OPTIONS
    
    ///  Return the value of the `Allow` header for the given URI.
    /// - Parameter url: the URL
    /// - Returns: nothing
    func optionsForAllow(url: String) async throws -> [HTTPMethod]
    
    ///  Return the value of the `Allow` header for the given URI.
    /// - Parameter url: the URL
    /// - Returns: nothing
    func optionsForAllow(url: URL) async throws -> [HTTPMethod]
    
    // MARK: - exchange
    
    /// Execute the HTTP method to the given URI template, writing the given request entity to the request,
    /// and return the response as ``ResponseEntity``.
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - requestEntity: the entity (headers and/or body) to write to the request (may be null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the response as entity
    func exchange<T>(url: String, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    /// Execute the HTTP method to the given URI template, writing the given request entity to the request,
    /// and return the response as ``ResponseEntity``.
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - requestEntity: the entity (headers and/or body) to write to the request (may be null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the response as entity
    func exchange<T>(url: URL, method: HTTPMethod, requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    /// Execute the request specified in the given ``RequestEntity`` and return
    /// the response as ``ResponseEntity``.
    /// - Parameters:
    ///   - requestEntity: the entity to write to the request
    ///   - responseType: the type to convert the response to
    /// - Returns: the response as entity
    func exchange<T>(requestEntity: RequestEntity<Codable?>, responseType: T.Type) async throws -> ResponseEntity<T>
    
    // MARK: - execute
    
    /// Execute the HTTP method to the given URI and reading the response to object
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - body: body to be sent with request (maybe null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the converted object
    func execute<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES?
    
    /// Execute the HTTP method to the given URI and reading the response to object
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - body: body to be sent with request (maybe null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the converted object
    func execute<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> RES?
    
    /// Execute the HTTP method to the given URI and reading the response to wrapped object with ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - body: body to be sent with request (maybe null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the converted object
    func executeForResponseEntity<RES: Codable>(url: String, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?>
    
    /// Execute the HTTP method to the given URI and reading the response to wrapped object with ``ResponseEntity``
    /// - Parameters:
    ///   - url: the URL
    ///   - method: the HTTP method (GET, POST, etc)
    ///   - body: body to be sent with request (maybe null)
    ///   - responseType: the type to convert the response to
    /// - Returns: the converted object
    func executeForResponseEntity<RES: Codable>(url: URL, method: HTTPMethod, body: Codable?, responseType: RES.Type) async throws -> ResponseEntity<RES?>
}
