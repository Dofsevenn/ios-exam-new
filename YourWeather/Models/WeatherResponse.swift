//
//  WeatherResponse.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct WeatherResponse: Decodable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}
