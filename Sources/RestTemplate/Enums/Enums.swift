//
//  Enums.swift
//  
//
//  Created by Vivek Topiya on 05/08/24.
//

import Foundation


///  Represents an HTTP request method. Intended for use ``RestTemplate``
public enum HTTPMethod: String {
    case GET
    case HEAD
    case POST
    case PUT
    case PATCH
    case DELETE
    case OPTIONS
    case TRACE
    
    public static func valueOf(method: String) -> HTTPMethod {
        switch method {
        case "GET": return .GET
        case "HEAD": return .HEAD
        case "POST": return .POST
        case "PUT": return .PUT
        case "PATCH": return .PATCH
        case "DELETE": return .DELETE
        case "OPTIONS": return .OPTIONS
        case "TRACE": return .TRACE
        default:
            return HTTPMethod(rawValue: method)!
        }
    }
}
