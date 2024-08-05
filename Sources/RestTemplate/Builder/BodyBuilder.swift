//
//  BodyBuilder.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

/// A builder for creating "Cache-Control" HTTP response headers.
public protocol CacheControl {}

/// support for quality parameters as defined in the HTTP specification.
public protocol MediaType {}

/// Defines a builder that adds a body to the response entity.
public protocol BodyBuilder {
    func header(headerName: String, headerValues: String...) -> BodyBuilder
    
    func header(headers: HttpHeaders?) -> BodyBuilder
    
    func allow(allowedMethods: HTTPMethod...) -> BodyBuilder
    
    func eTag(etag: String) -> BodyBuilder
    
    func lastModified(lastModified: Date) -> BodyBuilder
    
    func lastModified(lastModified: Int16) -> BodyBuilder
    
    func location(url: URL) -> BodyBuilder
    
    func cacheControl(cacheControl: CacheControl) -> BodyBuilder
    
    func varyBy(requestHeaders: String...) -> BodyBuilder
    
    func contentLength(contentLength: Int16) -> BodyBuilder
    
    func contentType(contentType: MediaType) -> BodyBuilder
    
    func body<T>(body: T?) -> ResponseEntity<T>
    
    func build<T>() -> ResponseEntity<T>
}

class DefaultBuilder: BodyBuilder {
    let statusCode: Any?
    let headers: HttpHeaders = .init()
    
    init(statusCode: Any?) {
        self.statusCode = statusCode
    }
    
    func header(headerName: String, headerValues: String...) -> BodyBuilder {
        fatalError()
    }
    
    func header(headers: HttpHeaders?) -> BodyBuilder {
        fatalError()
    }
    
    func allow(allowedMethods: HTTPMethod...) -> BodyBuilder {
        fatalError()
    }
    
    func eTag(etag: String) -> BodyBuilder {
        fatalError()
    }
    
    func lastModified(lastModified: Date) -> BodyBuilder {
        fatalError()
    }
    
    func lastModified(lastModified: Int16) -> BodyBuilder {
        fatalError()
    }
    
    func location(url: URL) -> BodyBuilder {
        fatalError()
    }
    
    func cacheControl(cacheControl: CacheControl) -> BodyBuilder {
        fatalError()
    }
    
    func varyBy(requestHeaders: String...) -> BodyBuilder {
        fatalError()
    }
    
    func contentLength(contentLength: Int16) -> BodyBuilder {
        fatalError()
    }
    
    func contentType(contentType: MediaType) -> BodyBuilder {
        fatalError()
    }
    
    func body<T>(body: T?) -> ResponseEntity<T> {
        return ResponseEntity(body: body, headers: self.headers, rawStatus: self.statusCode as! Int)
    }
    
    func build<T>() -> ResponseEntity<T> {
        return self.body(body: nil)
    }
}
