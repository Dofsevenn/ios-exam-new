//
//  Timeseries.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct Timeseries: Decodable {
    let time: Date
    let data: Data
}
