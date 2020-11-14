//
//  MapView.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 11/11/2020.
//

//  Icon virker må bare fikse at det oppdateres med en gang og ikke når man går inn i værmelding og tilbake

import MapKit
import SwiftUI
import CoreLocation

struct MapView: View {
    @ObservedObject var weatherVM = WeatherViewModel()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
  
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Map(coordinateRegion: $locationManager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode)
                .onAppear {
                    manager.delegate = locationManager
                    manager.requestWhenInUseAuthorization()
                    manager.requestAlwaysAuthorization()
                    if CLLocationManager.locationServicesEnabled() {
                        manager.startUpdatingLocation()
                    }
                    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                        print("authorized")
                        weatherVM.fetchWeatherSymbolInfo()
                        weatherVM.fetchWeatherData()
                    }
                }
            
            HStack{
                VStack{
                Text("Breddegrad: \(manager.location?.coordinate.latitude ?? 0)")
                    .padding(.leading)
                Text("Lengdegrad: \(manager.location?.coordinate.longitude ?? 0)")
                    .padding(.leading)
                }
                Spacer()
                Image(weatherVM.iconImage) // Virker må bare fikse at det oppdateres med en gang og ikke når man går inn i værmelding og tilbake
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(20)
            }
        } else {
            // Fallback on earlier versions
            //Skrive kode her hvis jeg har tid og det er nødvendig for oppgaven
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("authorized")
        } else {
            print("not autorized")
            manager.requestWhenInUseAuthorization()
        }
        
        let accuracyAuthorization = manager.accuracyAuthorization
        switch accuracyAuthorization {
        case .fullAccuracy:
            break
        case .reducedAccuracy:
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        
        setCurrentUserLocationCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
