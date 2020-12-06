//
//  SwiftUIView.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 30/11/2020.
//
import Combine
import SwiftUI
import CoreLocation

struct HomeView: View {
    
    func onLocationReceived(coordinate: CLLocation) {
        //if coordinate != coordinate.last {
            locationManager.weatherVM.fetchWeatherSymbolInfo()
            locationManager.weatherVM.fetchWeatherData()
       //}
    }
    
    //@Binding var isLoaded: Bool
    //@ObservedObject var weatherVM = WeatherViewModel()
    
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    //@State var weatherIcon = ""
   // private var weatherIcon: String { isLoaded ? "clearsky_day" : "clearsky_night"}
    
     init() {
        manager.delegate = locationManager
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.distanceFilter = 1000 // Må se mer på denne
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Mandag")
                .font(.system(size: 40))
            //if isLoaded == true {
                Image("\(locationManager.weatherVM.showWetherIconHome)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(20)
           // }
            
            Spacer()
            Image(systemName: "unbrella-fill")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
           /* if locationManager.weatherVM.showWetherIconHome == "umbrella.fill" {
                Image(systemName: locationManager.weatherVM.showWetherIconHome)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Image(locationManager.weatherVM.showWetherIconHome)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } */
            Spacer()
            Text("Ta med paraply i dag, det blir regn!")
                .font(.system(size: 30))
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
