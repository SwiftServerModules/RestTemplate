//
//  HttpEntity.swift
//  
//
//  Created by Vivek Topiya on 21/05/24.
//

import Foundation

public class HTTPEntity<T>{
    public var EMPTY: HTTPEntity<T> = HTTPEntity<T>()
    
    let headers: HttpHeaders?
    let body: T?
    
    convenience init(){
        self.init(body: nil, headers: nil )
    }
    
    init(body: T?, headers:HttpHeaders?) {
        self.body = body
        self.headers = headers
    }
    
    func hasBody() -> Bool{
        return self.body != nil
    }
    
}
