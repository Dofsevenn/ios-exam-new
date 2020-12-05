//
//  MapView.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 11/11/2020.
//
import Combine
import MapKit
import SwiftUI
import CoreLocation

struct MapView: View {

    @ObservedObject var weatherVM = WeatherViewModel()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
  
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    
    @State var showAnnotationView = false
    @State var annotation = MKPointAnnotation()
    @State var weatherIcon = ""
    
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
                                
                                weatherVM.fetchWeatherSymbolInfo()
                                weatherVM.fetchWeatherData()
                            }
                            //locationManager.setLocation { success in
                             //   if success {
                                   
                               // }
                           // }
                            
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
                
                MapViewModel(annotation: $annotation, weatherIcon: $weatherIcon)
                    //.edgesIgnoringSafeArea(.all)
            
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
                Image("\(weatherIcon)") // Virker må bare fikse at det oppdateres med en gang og ikke når man går inn i værmelding og tilbake
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
            Image(weatherVM.iconImageNextHour) // Virker må bare fikse at det oppdateres med en gang og ikke når man går inn i værmelding og tilbake
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(20)
        }
        }
    }
}

protocol LocationCallbackProtocol {
    func onLocationReceived(coordinate: CLLocation)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var callback: LocationCallbackProtocol?
    @ObservedObject var weatherVM = WeatherViewModel()
    @Published var region = MKCoordinateRegion()
    
    @ObservedObject var router = Router()
    //@Published var location = CLLocation()
   
    
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
        self.callback?.onLocationReceived(coordinate: location)
        
       // let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       // let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
       // let region = MKCoordinateRegion(center: center, span: span)
        
        setCurrentUserLocationCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
            
            weatherVM.fetchWeatherSymbolInfo()
            weatherVM.fetchWeatherData()
        
    }
    /*
    func setLocation(completion: @escaping (_ success: Bool) -> Void) {
        setCurrentUserLocationCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        completion(true)
    }
    */
    
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
