//
//  Meta.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

struct Meta: Decodable {
    let updateAt: String // Må finne ut av hvilken tids formatering som brukes
    let units: Units
    
    enum CodingKeys: String, CodingKey {
        case updateAt = "updated_at"
        case units
    }
}
