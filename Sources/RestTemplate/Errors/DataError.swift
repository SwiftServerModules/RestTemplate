//
//  DataError.swift
//  
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

public enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

