//
//  Data.swift
//  YourWeather
//
//

import Foundation

struct Data: Decodable {
    let instant: Instant
    let next12Hours: Next12Hours?
    let nextHours: NextHour?
    let next6Hours: Next6Hours?
    
    enum CodingKeys: String, CodingKey {
        case instant
        case next12Hours = "next_12_hours"
        case nextHours = "next_1_hours"
        case next6Hours = "next_6_hours"
    }
}
