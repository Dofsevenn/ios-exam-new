//
//  NextHour.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct NextHour: Decodable {
    let summary: Summary
    let details: HourlyDetails
}

