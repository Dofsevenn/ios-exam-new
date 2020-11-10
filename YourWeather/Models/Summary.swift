//
//  Summary.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct Summary: Decodable {
    let symbolCode: String
    
    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}
