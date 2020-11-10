//
//  HourlyDetails.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct HourlyDetails: Decodable {
    let precipitationAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}
