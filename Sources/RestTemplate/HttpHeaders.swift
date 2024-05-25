//
//  HttpHeaders.swift
//  
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

public struct HttpHeaders{
    public static let AUTHORIZATION: String = "Authorization"
    
    public static func encodeBasicAuth(_ username: String, _ password: String) -> String {
        return ((username + ":" + password)
            .data(using: .isoLatin1)!
            .base64EncodedString())
    }
    
}
