//
//  RestClient.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

/// exceptions thrown by ``RestTemplate`` in case a request fails because of a server error response
public enum RestClientError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}
