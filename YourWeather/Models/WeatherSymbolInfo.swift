//
//  WeatherSymbolInfo.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 05/11/2020.
//

import Foundation

struct WeatherSymbolInfo: Decodable {
    let oldID: Int
    let descNb: String
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case oldID = "old_id"
        case descNb = "desc_nb"
        case variants
    }
}

enum Variant: String, Codable {
    case day = "day"
    case night = "night"
    case polartwilight = "polartwilight"
}
