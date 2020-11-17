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

var annotationLat = "59.911166"
var annotationLon = "10.744810"

func setCurrentUserLocationCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    // Format to onely show 6 desimals, that is for the looks of the UI
    lat = String(format: "%.6f", latitude)
    lon = String(format: "%.6f", longitude)
    name = lat + ", " + lon
}

func setAnnotationsCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    // Format to onely show 6 desimals, that is for the looks of the UI
    annotationLat = String(format: "%.6f", latitude)
    annotationLon = String(format: "%.6f", longitude)
}

struct WeatherResponse: Decodable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}
