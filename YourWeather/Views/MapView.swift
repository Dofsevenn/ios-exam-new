//
//  MapView.swift
//  YourWeather
//
// The reference to the sources I have been inspired by for the code in this file is in the README.md

import Combine
import MapKit
import SwiftUI
import CoreLocation

struct MapView: View{
    @ObservedObject var weatherVM = WeatherViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    @State var showAnnotationView = false
    @State var annotation = MKPointAnnotation()
    @State var weatherIcon = ""
    
    var body: some View {
        
        ZStack(){
            
                if #available(iOS 14.0, *) {
                    Map(coordinateRegion: $locationManager.region,
                        interactionModes: .all,
                        showsUserLocation: true,
                        userTrackingMode: $userTrackingMode)
                        .onAppear {
                            manager.delegate = locationManager
                            manager.requestWhenInUseAuthorization()
                            manager.requestAlwaysAuthorization()
                            manager.distanceFilter = 1000 // Må se mer på denne
                            if CLLocationManager.locationServicesEnabled() {
                                manager.startUpdatingLocation()
                            }
                        }
                } else {
                    // Fallback on earlier versions
                    // Didn't have time to do this.
                }
            VStack{
                HStack{
                    Toggle(isOn: $showAnnotationView) {
                    
                    }.padding(30)
                    Spacer()
                }
                Spacer()
            }
            if showAnnotationView {
                
                // I have chosen not to use region here, to make it easier for the user to choose any place in the world to get forcast, instead of being zoomed in on a specific place.
                MapViewModel(annotation: $annotation, weatherIcon: $weatherIcon)
            
                VStack{
                    HStack{
                        Toggle(isOn: $showAnnotationView) {
                        
                        }.padding(30)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        
        if showAnnotationView {
            HStack{
                VStack{
                    Text("Breddegrad: \(annotation.coordinate.latitude)")
                        .padding(.leading)
                        .padding(.bottom)
                    Text("Lengdegrad: \(annotation.coordinate.longitude)")
                        .padding(.leading)
                }
                Spacer()
                Image("\(weatherIcon)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding(20)
            }
        } else {
            
        HStack{
            VStack{
                Text("Breddegrad: \(manager.location?.coordinate.latitude ?? 0)")
                    .padding(.leading)
                    .padding(.bottom)
                Text("Lengdegrad: \(manager.location?.coordinate.longitude ?? 0)")
                    .padding(.leading)
            }
            Spacer()                              
            Image(locationManager.weatherVM.iconImageNextHour)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(20)
        }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @ObservedObject var weatherVM = WeatherViewModel()
    @Published var region = MKCoordinateRegion()
    
    @ObservedObject var router = Router()
    @Published var homeIcon = ""
   
    
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
        guard let location = locations.last  else {
            print("no location")
            return
        }
        print("Fetched location")
      
        setCurrentUserLocationCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        weatherVM.fetchWeatherSymbolInfo()
        weatherVM.fetchWeatherData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.homeIcon = self.weatherVM.showWetherIconHome
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error =  error as? CLError, error.code == .denied {
            manager.stopUpdatingLocation()
            return
        }
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
