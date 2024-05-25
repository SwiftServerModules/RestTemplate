//
//  ResponseEntity.swift
//  
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation


public class ResponseEntity<T>: HTTPEntity<T>{
    let status: Any
    
    convenience init(status: HTTPStatus) {
        self.init(body: nil, headers: nil, status: status)
    }
    
    convenience init(body: T?,status: HTTPStatus) {
        self.init(body: body, headers: nil, status: status)
    }
    
    convenience init(headers: HttpHeaders,status: HTTPStatus) {
        self.init(body: nil, headers: headers, status: status)
    }
    
    convenience init(body: T?,headers: HttpHeaders?,status: HTTPStatus) {
        self.init(body: body, headers: headers, status: status as Any)
    }
    
    convenience init(body: T?,headers: HttpHeaders?,rawStatus: Int) {
        self.init(body: body, headers: headers, status: rawStatus as Any)
    }
    
    init(body: T?,headers: HttpHeaders?,status: Any) {
        self.status = status
        super.init(body: body,headers: headers)
    }
    
    func getStatusCode() -> HTTPStatus {
        if self.status is Int {
            return HTTPStatus.valueOf(statusCode: self.status as! Int)
        }
        return self.status as! HTTPStatus
    }
    
    func getStatusCodeValue() -> Int{
        if self.status is Int {
            return self.status as! Int
        }
        return (self.status as! HTTPStatus).value
    }
    
    // MARK: - static methods
    
    public static func status(status: HTTPStatus) -> BodyBuilder{ DefaultBuilder(statusCode: status.value) }
    
    public static func status(status: Int) -> BodyBuilder{ DefaultBuilder(statusCode: status) }
    
    public static func ok() -> BodyBuilder { status(status: .OK) }
    
    public static func ok<T>(body: T?) -> ResponseEntity<T>{ ok().body(body: body) }
    
    public static func of<T>(body: T?) -> ResponseEntity<T> {
        guard let body = body else{ return notFound().build() }
        return ok(body: body)
    }
    
    public static func created(uri: URL) -> BodyBuilder { status(status: .CREATED).location(url: uri) }
    
    public static func accepted() -> BodyBuilder { status(status: .CREATED) }
    
    public static func noContent() -> BodyBuilder { status(status: .NO_CONTENT) }
    
    public static func badRequest() -> BodyBuilder { status(status: .BAD_REQUEST) }
    
    public static func notFound() -> BodyBuilder { status(status: .NOT_FOUND) }
    
    public static func unprocessableEntity() -> BodyBuilder { status(status: .UNAUTHORIZED) }
    
    public static func internalServerError() -> BodyBuilder {status(status: .INTERNAL_SERVER_ERROR) }
    
}
