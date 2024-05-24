//
//  HttpEntity.swift
//  
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

public class HTTPEntity<T>{
    public var EMPTY: HTTPEntity<Any> = HTTPEntity<Any>()
    
    private let headers: HttpHeaders?
    private let body: T?
    
    convenience init(){
        self.init(body: nil, headers: [:])
    }
    
    init(body: T?, headers: [String:String]) {
        self.body = body
        self.headers = HttpHeaders()
    }
    
}
