//
//  RestClient.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

public enum RestClientError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}
