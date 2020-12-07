//
//  SwiftUIView.swift
//  YourWeather

// The reference to the sources I have been inspired by for the code is in th README.md

import Combine
import SwiftUI
import CoreLocation

struct HomeView: View {
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    @State var homeIcon = ""
    @State var rotating = false
    
     init() {
        manager.delegate = locationManager
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.distanceFilter = 1000
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        locationManager.weatherVM.fetchWeatherSymbolInfo()
        locationManager.weatherVM.fetchWeatherData()
    }
    
    var body: some View {

        VStack {
            
            Spacer()
            
            if locationManager.homeIcon == "" {
                Text("")
            } else {
                Text(locationManager.weatherVM.day)
                    .font(.system(size: 40))
            }
            
            Spacer()

            if locationManager.weatherVM.showWetherIconHome == "umbrella.fill" {
                Image(systemName: locationManager.homeIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else if locationManager.weatherVM.showWetherIconHome == "clearsky_day" {
                Image(locationManager.homeIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .rotationEffect(.degrees(rotating ? 360 : 0), anchor: .center)
                    .animation(Animation.linear(duration: 30)
                                .repeatForever(autoreverses: false))
                    .onAppear() {
                        self.rotating.toggle()
                    }
            } else {
                Image(locationManager.homeIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            Spacer()
            
            if locationManager.homeIcon == "umbrella.fill" {
                Text("Ta med paraply i dag, det blir regn!")
                    .font(.system(size: 30))
            } else if locationManager.homeIcon == "" {
                Text("")
            } else {
                Text("Du trenger ingen paraply idag.")
                    .font(.system(size: 30))
            }
            
            Spacer()
        }
        if locationManager.weatherVM.showWetherIconHome == "umbrella.fill" {
            Image(systemName: "drop.fill")
                .foregroundColor(.blue)
                .animation(
                    Animation.easeIn(duration: 3)
                        .repeatForever(autoreverses: false)
                )
                .transition(.offset(x: 0, y: -650))
            
            
            Image(systemName: "drop.fill")
                .offset(x: 100, y: 0)
                .foregroundColor(.blue)
                .animation(
                    Animation.easeIn(duration: 3)
                        .repeatForever(autoreverses: false)
                        .delay(1)
                    )
                .transition(.offset(x: 0, y: -650))
            
            Image(systemName: "drop.fill")
                .offset(x: -100, y: 0)
                .foregroundColor(.blue)
                .animation(
                    Animation.easeIn(duration: 3)
                        .repeatForever(autoreverses: false)
                        .delay(0.5)
                )
                .transition(.offset(x: 0, y: -650))
        
        } else if locationManager.weatherVM.showWetherIconHome  == "clearsky_day" {
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
