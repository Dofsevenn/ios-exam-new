//
//  Details.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct InstantDetails: Decodable {
    let air_pressure_at_sea_level: Double
    let air_temperature: Double
    let cloud_area_fraction: Double
    let relative_humidity: Double
    let wind_from_direction: Double
    let wind_speed: Double
}
