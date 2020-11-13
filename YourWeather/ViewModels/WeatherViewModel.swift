//
//  WeatherViewModel.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 02/11/2020.
//

//import Combine
import Foundation
import Dispatch

class WeatherViewModel: ObservableObject {
    @Published private var weatherData: WeatherResponse?
    
    @Published private var symbolData = [Symbol]()

    
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
            if symbolCode.contains(symbol.key)  {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_night" {  //Sjekke om dette funker, ellers ta det bort eller fikse det.
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb
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
            if symbolCode.contains(symbol.key)  {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_night" {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb
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
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_day" {
                symbolCode = symbol.value.descNb
            } else if symbolCode == symbol.key + "_polartwilight" {
                symbolCode = symbol.value.descNb
            }
        }
        return symbolCode
    }
    
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
                    print("Something went wrong with the decoding")
                }
            }
        }
    }
    
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
                    print("Something went wrong with the decoding")
                }
            }
        }
    }
    /*
    func fetchWeatherDataUserLocation() {
        
        Webservice().getWeatherUpdatesUserLocation { result in
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
                    print("Something went wrong with the decoding")
                }
            }
        }
    } */
    
}