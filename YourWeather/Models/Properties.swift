//
//  Properties.swift
//  YourWeather
//
//

import Foundation

struct Properties: Decodable {
    let meta: Meta
    let timeseries: [Timeseries]
}
