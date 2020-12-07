//
//  HourlyDetails.swift
//  YourWeather
//
//

import Foundation

struct HourlyDetails: Decodable {
    let precipitationAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}
