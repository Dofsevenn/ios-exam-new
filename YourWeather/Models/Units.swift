//
//  Units.swift
//  YourWeather
//
//

import Foundation

struct Units: Decodable {
    let airPressureAtSeaLevel: String
    let airTemperature: String
    let cloudAreaFraction: String
    let precipitationAmount: String
    let relativeHumidity: String
    let windFromDirection: String
    let windSpeed: String
    
    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case precipitationAmount = "precipitation_amount"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}
