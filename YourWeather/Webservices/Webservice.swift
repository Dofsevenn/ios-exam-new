//
//  Webservice.swift
//  YourWeather
//
// The reference to the sources I have been inspired by for the code is in th README.md. It is quite similar to the video I saw, but the most of the api calls I saw on google was almost the same, så I guess it's not to many ways of doing it.

import Combine
import Foundation
import SwiftUI

enum NetworkError: Error, LocalizedError, Identifiable {
    
    case UrlFault
    case getDataFailed
    case decodingError
    
    var id: String { localizedDescription }
    
    var errorDescription: String? {
        switch self {
        case .UrlFault: return "Something wrong with the url"
        case .getDataFailed: return "found no data"
        case .decodingError: return "Something went wrong with decoding"
        }
    }
}

class Webservice: Identifiable {
    @ObservedObject var locationManager = LocationManager()
    
    
    
    func getWeatherUpdates(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(lat)&lon=\(lon)#") else {
            completion(.failure(.UrlFault))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.getDataFailed))
                    return
                }
                
                let decoder = JSONDecoder()
                
                // Formatting the date from String to Date
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let weather = try? decoder.decode(WeatherResponse.self, from: data)
            
                if let weather = weather {
                    completion(.success(weather))
                } else {
                    completion(.failure(.decodingError))
                    
                }
            }
        }.resume()
    }

    func getWeatherSymbolsInfo(completion: @escaping (Result<Symbol, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.met.no/weatherapi/weathericon/2.0/legends#") else {
            completion(.failure(.UrlFault))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.getDataFailed))
                    return
                }
                
                let decoder = JSONDecoder()
                
                let symbolInfo = try? decoder.decode(Symbol.self, from: data)
                
                if let symbolInfo = symbolInfo {
                    completion(.success(symbolInfo))
                    print(symbolInfo)
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    // I made a new api call function here just to seperate it from the userLocation coordinate call. I also did it because I had to use UIKit for the annotation part, and I didn't want any problems from interract between SwiftUI and UIKit. There is probably a bether, and less re-use of code, way to do this.
    func getWeatherUpdatesAnnotations(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(annotationLat)&lon=\(annotationLon)#") else {
            completion(.failure(.UrlFault))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.getDataFailed))
                    return
                }
                
                let decoder = JSONDecoder()
                
                // Formatting the date from String to Date
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let weather = try? decoder.decode(WeatherResponse.self, from: data)
            
                if let weather = weather {
                    completion(.success(weather))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    // I made another api call function here to seperate the calls to HomeView. This is so that Kristiania still is going  to be the first forcast on "Værmelding" page. I think there is better ways to do this, but I did not have more time because of covid-19.
    func getWeatherUpdatesHome(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(homeLat)&lon=\(homeLon)#") else {
            completion(.failure(.UrlFault))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.getDataFailed))
                    return
                }
                
                let decoder = JSONDecoder()
                
                // Formatting the date from String to Date
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let weather = try? decoder.decode(WeatherResponse.self, from: data)
            
                if let weather = weather {
                    completion(.success(weather))
                } else {
                    completion(.failure(.decodingError))
                    
                }
            }
        }.resume()
    }
}
