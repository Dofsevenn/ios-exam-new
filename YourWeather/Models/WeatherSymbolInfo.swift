//
//  WeatherSymbolInfo.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 05/11/2020.
//

import Foundation

struct WeatherSymbolInfo: Codable, Equatable {
    let descNb: String
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case descNb = "desc_nb"
        case variants
    }
}

enum Variant: String, Codable, Equatable {
    case day = "day"
    case night = "night"
    case polartwilight = "polartwilight"
}

typealias Symbol = [String: WeatherSymbolInfo]
