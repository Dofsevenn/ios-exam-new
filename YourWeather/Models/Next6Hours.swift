//
//  Next6Hours.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct Next6Hours: Decodable {
    let summary: Summary
    let details: HourlyDetails
}
