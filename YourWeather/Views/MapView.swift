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
    
    @State var showAnnotationView = false
    
    //var map: Map<MapView>
    
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
                            locationManager.weatherVM.fetchWeatherSymbolInfo()
                            locationManager.weatherVM.fetchWeatherData()
                        }
                    
                } else {
                    // Fallback on earlier versions
                    //Skrive kode her hvis jeg har tid og det er nødvendig for oppgaven
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
                //let longPress = UILongPressGestureRecognizer(target: self, action: #selector(Map.mapLongPress(_:)))
                //longPress.minimumPressDuration = 1.5
                MapViewTest()
                .edgesIgnoringSafeArea(.all)
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
        HStack{
            VStack{
                Text("Breddegrad: \(manager.location?.coordinate.latitude ?? 0)")
                    .padding(.leading)
                    .padding(.bottom)
                Text("Lengdegrad: \(manager.location?.coordinate.longitude ?? 0)")
                    .padding(.leading)
            }
            Spacer()
            Image(locationManager.weatherVM.iconImageNextHour) // Virker må bare fikse at det oppdateres med en gang og ikke når man går inn i værmelding og tilbake
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(20)
        }
    }
    
    
    func mapLongPress(_ recognizer: UIGestureRecognizer) {
        //print("Longpress has been detected")
        
        //let touchedAt = recognizer.location(in: self.map)
    }
}



class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @ObservedObject var weatherVM = WeatherViewModel()
    @Published var region = MKCoordinateRegion()
    @Published var newPin = MKPointAnnotation()
    
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
       
        weatherVM.fetchWeatherSymbolInfo()
        weatherVM.fetchWeatherData()
        
        func annotations() {
            newPin.coordinate = location.coordinate
        }
    }
    
    /*locationManager(_:didFailWithError:){
        // Må fikse denne
    }*/
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
