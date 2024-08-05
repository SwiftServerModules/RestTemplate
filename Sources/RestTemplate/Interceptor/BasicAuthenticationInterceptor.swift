//
//  BasicAuthenticationInterceptor.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

/// implementation of ``ClientHttpRequestInterceptor``  to apply a given HTTP Basic Authentication username/password pair,
/// unless a custom Authorization header has already been set.
/// 
/// usage
/// ```swift
/// rt.interceptors = [
/// BasicAuthenticationInterceptor(username: "abc", password: "def"),
/// ]
/// ```	
public struct BasicAuthenticationInterceptor: ClientHttpRequestInterceptor {
    private let encodedCredentials: String
    
    /// Create a new interceptor which adds Basic Authentication for the given username and password.
    /// - Parameters:
    ///   - username: the username to use
    ///   - password: the password to use
    init(username: String, password: String) {
        self.encodedCredentials = HttpHeaders.encodeBasicAuth(username, password)
    }
    
    public func intercept(_ request: inout URLRequest, _ body: Data?) {
        // do not set auth header if already present
        guard let headers = request.allHTTPHeaderFields, headers[HttpHeaders.AUTHORIZATION] == nil
        else { return }
        
        request.addValue(encodedCredentials, forHTTPHeaderField: HttpHeaders.AUTHORIZATION)
    }
}
