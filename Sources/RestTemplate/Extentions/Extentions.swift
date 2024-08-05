//
//  Extentions.swift
//  
//
//  Created by Vivek Topiya on 05/08/24.
//

import Foundation

extension Encodable {
    /// A little helper method to convert codable object to Json data
    /// - Returns: Json data to set in request boday
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
