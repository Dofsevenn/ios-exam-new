//
//  WeatherViewModel.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 02/11/2020.
//

// Lagen en variabel med closure med en switch som har alle mulighetene på norsk i forhold til symbolcode.

import Combine
import Foundation
import Dispatch

class WeatherViewModel: ObservableObject {
    @Published private var symbolData = [Symbol]()
    @Published private var weatherData: WeatherResponse?
    @Published var error: NetworkError?
    
    // Instant properties
    var instantTemperature: Double {
        guard let temperature = weatherData?.properties.timeseries[0].data.instant.details.airTemperature else {
            return 0
        }
        return temperature

    }
    
    var instantText: String {
        guard let text = weatherData?.properties.meta.units.airTemperature else {
            return ""
        }
        return text
    }
    
    //TODO: Må kunne automatisere disse greiene her
    
    // NextHour properties
    var nextHourSummary: String {
        guard var symbolCode = weatherData?.properties.timeseries[0].data.nextHours?.summary.symbolCode else {
            return ""
        }
        for symbol in self.symbolData[0] {
            if symbolCode == (symbol.key)  {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_night" {  //Sjekke om dette funker, ellers ta det bort eller fikse det.
                symbolCode = symbol.value.descNb + " (natt)"
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb + " (dag)"
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb + " (polar skumring)"
            }
        }
        
        return symbolCode
    }
    
    var nextHourDetails: Double {
        guard let precipitationAmount = weatherData?.properties.timeseries[0].data.nextHours?.details.precipitationAmount else {
            return 0
        }
        return precipitationAmount
    }
    
    var nextHourPrecipitationText: String {
        guard let precipitationText = weatherData?.properties.meta.units.precipitationAmount else {
            return ""
        }
        return precipitationText
    }
    
    // Next6Hours properties
    var next6HourSummary: String {
        guard var symbolCode = weatherData?.properties.timeseries[0].data.next6Hours?.summary.symbolCode else {
            return ""
        }
        
        for symbol in self.symbolData[0] {
            if symbolCode == (symbol.key)  {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_night" {
                symbolCode = symbol.value.descNb + " (natt)"
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb + " (dag)"
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb + " (polar skumring)"
            }
        }
        return symbolCode
    }
    
    var next6HourDetails: Double {
        guard let precipitationAmount = weatherData?.properties.timeseries[0].data.next6Hours?.details.precipitationAmount else {
            return 0
        }
        return precipitationAmount
    }
    
    var next6HourPrecipitationText: String {
        guard let precipitationText = weatherData?.properties.meta.units.precipitationAmount else {
            return ""
        }
        return precipitationText
    }
    
    // Next12Hours properties
    var next12HorsSummary: String {
        guard var symbolCode = weatherData?.properties.timeseries[0].data.next12Hours?.summary.symbolCode else {
            return ""
        }
        
        for symbol in self.symbolData[0] {
            if symbolCode == (symbol.key)  {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_night" {
                symbolCode = symbol.value.descNb + " (natt)"
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb + " (dag)"
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb + " (polar skumring)"
            }
        }
        return symbolCode
    }
    
    var iconImageNextHour: String {
        guard let symbolCode = weatherData?.properties.timeseries[0].data.nextHours?.summary.symbolCode else {
            return ""
        }
        var icon = ""
        
        for symbol in self.symbolData[0] {
            if symbolCode == symbol.key {
                icon = symbol.key
            } else if symbolCode == symbol.key + "_night" {
                icon = symbol.key + "_night"
            } else if symbolCode == symbol.key + "_day" {
                icon = symbol.key + "_day"
            } else if symbolCode == symbol.key + "_polartwilight" {
                icon = symbol.key + "_polartwilight"
            }
        }
        return icon
    }
    
    var iconImageNext6Hours: String {
        guard let symbolCode = weatherData?.properties.timeseries[0].data.next6Hours?.summary.symbolCode else {
            return ""
        }
        var icon = ""
        
        for symbol in self.symbolData[0] {
            if symbolCode == symbol.key {
                icon = symbol.key
            } else if symbolCode == symbol.key + "_night" {
                icon = symbol.key + "_night"
            } else if symbolCode == symbol.key + "_day" {
                icon = symbol.key + "_day"
            } else if symbolCode == symbol.key + "_polartwilight" {
                icon = symbol.key + "_polartwilight"
            }
        }
        return icon
    }
    
    var iconImageNext12Hours: String {
        guard let symbolCode = weatherData?.properties.timeseries[0].data.next12Hours?.summary.symbolCode else {
            return ""
        }
        var icon = ""
        
        for symbol in self.symbolData[0] {
            if symbolCode == symbol.key {
                icon = symbol.key
            } else if symbolCode == symbol.key + "_night" {
                icon = symbol.key + "_night"
            } else if symbolCode == symbol.key + "_day" {
                icon = symbol.key + "_day"
            } else if symbolCode == symbol.key + "_polartwilight" {
                icon = symbol.key + "_polartwilight"
            }
        }
        
        return icon
    }
    
    var showWetherIconHome: String {
        var icon = ""
        
        guard let symbolCode = weatherData?.properties.timeseries[0].data.next12Hours?.summary.symbolCode else {
            return ""
        }
        
        if symbolCode.contains("rain") {
            icon = "umbrella.fill"
        } else {
            icon = "clearsky_day"
        }
        print("icon is:" + icon)
        return icon
        
    }
    
    
    
    // Fetching data with the userlocation coordinates
    func fetchWeatherData() {
        
        Webservice().getWeatherUpdates { result in
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                switch error {
                case .UrlFault:
                    print("Something wrong with the url")
                case .getDataFailed:
                    print("found no data")
                case .decodingError:
                    print("Something went wrong with decoding")
                }
                self.error = error
            }
        }
    }
    
    // Fetchin the the weather Symbol Info
    func fetchWeatherSymbolInfo() {
        
        Webservice().getWeatherSymbolsInfo { result in
            switch result {
            case .success(let symbolInfo):
                self.symbolData.append(symbolInfo)
                print(self.symbolData)
            case .failure(let error):
                switch error {
                case .UrlFault:
                    print("Something wrong with the url")
                case .getDataFailed:
                    print("found no data")
                case .decodingError:
                    print("Something went wrong with decoding")
                }
                self.error = error
            }
        }
    }
    
    // Fetching data with the annotation coordinates
    func fetchWeatherDataAnnotation() {
        
        Webservice().getWeatherUpdatesAnnotations { result in
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                switch error {
                case .UrlFault:
                    print("Something wrong with the url")
                case .getDataFailed:
                    print("found no data")
                case .decodingError:
                    print("Something went wrong with decoding")
                }
                self.error = error
            }
        }
    }
    
    // Fetching data with the userlocation coordinates
    func fetchWeatherDataHome() {
        
        Webservice().getWeatherUpdatesHome { result in
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                switch error {
                case .UrlFault:
                    print("Something wrong with the url")
                case .getDataFailed:
                    print("found no data")
                case .decodingError:
                    print("Something went wrong with decoding")
                }
                self.error = error
                
            }
        }
    }

}
