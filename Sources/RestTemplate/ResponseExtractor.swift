//
//  ResponseExtractor.swift
//
//
//  Created by Vivek Topiya on 28/05/24.
//

import Foundation

/// Generic callback methods used by ``RestTemplate``'s retrieval methods.
class ResponseExtractor {
    private let jsonDecoder: JSONDecoder = .init()

    func extractData<T: Codable>(response: HTTPURLResponse, data: Data, responseType: T.Type) throws -> ResponseEntity<T?> {
        // decode data to swift object and create ResponseEntity object
        do {
            let resObj = try jsonDecoder.decode(responseType.self, from: data)
            return ResponseEntity(body: resObj, status: HTTPStatus.valueOf(statusCode: response.statusCode))
        } catch {
            throw RestClientError.invalidData
        }
    }

    func extractData<T: Codable>(response: HTTPURLResponse, data: Data, responseType: T.Type) throws -> T? {
        // decode data to swift object
        do {
            return try jsonDecoder.decode(responseType.self, from: data)
        } catch {
            throw RestClientError.invalidData
        }
    }
}
