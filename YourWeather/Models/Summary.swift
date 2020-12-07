//
//  Summary.swift
//  YourWeather
//
//

import Foundation

struct Summary: Decodable {
    let symbolCode: String
    
    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}
