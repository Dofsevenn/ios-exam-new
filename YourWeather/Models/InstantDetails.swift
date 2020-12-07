//
//  Details.swift
//  YourWeather
//
//

import Foundation

struct InstantDetails: Decodable {
    let airPressureAtSeaLevel: Double
    let airTemperature: Double
    let cloudAreaFraction: Double
    let relativeHumidity: Double
    let windFromDirection: Double
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}
