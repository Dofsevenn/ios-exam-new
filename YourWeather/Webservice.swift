//
//  Webservice.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 28/10/2020.
//

import Foundation

enum NetworkError: Error {
    case UrlFault
    case getDataFailed
    case decodingError
}

class Webservice: ObservableObject {
    
    func getWeatherUpdatesKristiania(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810#") else {
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

    func getWeatherSymbolsInfo(completion: @escaping (Result<WeatherSymbolInfo, NetworkError>) -> Void) {
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
                
                let symbolInfo = try? decoder.decode(WeatherSymbolInfo.self, from: data)
                
                if let symbolInfo = symbolInfo {
                    completion(.success(symbolInfo))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
