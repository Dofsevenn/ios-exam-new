//
//  Next6Hours.swift
//  YourWeather
//
//

import Foundation

struct Next6Hours: Decodable {
    let summary: Summary
    let details: HourlyDetails
}
