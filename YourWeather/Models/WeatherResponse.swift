//
//  WeatherResponse.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//
import CoreLocation
import Foundation

var lat: String = "59.911166"
var lon: String = "10.744810"
var name: String = "Høyskolen Kristiania"

func setWeatherCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    lat = String(format: "%.6f", latitude)
    lon = String(format: "%.6f", longitude)
    name = lat + ", " + lon
}

struct WeatherResponse: Decodable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}
