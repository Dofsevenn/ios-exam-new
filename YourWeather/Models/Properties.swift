//
//  Properties.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct Properties: Decodable {
    let meta: Meta
    let timeseries: [Timeseries]
}
