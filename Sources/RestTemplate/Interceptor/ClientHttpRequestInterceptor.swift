//
//  ClientHttpRequestInterceptor.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

/// Intercepts client-side HTTP requests. Implementations of this interface can be ``RestTemplate``'s interceptops variable
public protocol ClientHttpRequestInterceptor {
    /// Intercept the given request, modifiable object for adding custom header or customizing request
    /// - Parameters:
    ///   - request: modifiable request object
    ///   - body: modifiable body object
    func intercept(_ request: inout URLRequest, _ body: Data?)
}
