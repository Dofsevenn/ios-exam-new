//
//  Meta.swift
//  YourWeather
//
//

import Foundation

struct Meta: Decodable {
    let updateAt: String 
    let units: Units
    
    enum CodingKeys: String, CodingKey {
        case updateAt = "updated_at"
        case units
    }
}
