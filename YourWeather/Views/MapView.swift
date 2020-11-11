//
//  MapView.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 11/11/2020.
//

import MapKit
import SwiftUI
import CoreLocation

// Hent ut lat long fra current location, sette det som default, og vise været on tap
// Lage globael lat lon variabler som kan hentes ut

struct MapView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.911166, longitude: 10.744810), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @State var locationManager = CLLocationManager()
    @StateObject var managerDelegate = LocationManager()
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Map(coordinateRegion: $coordinateRegion,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode)
                .onAppear {
                    locationManager.delegate = managerDelegate
                    locationManager.requestAlwaysAuthorization()
                    locationManager.startUpdatingLocation()
                   
                } 
                
        } else {
            // Fallback on earlier versions
            //Skrive kode her hvis jeg har tid og det er nødvendig for oppgaven
        }
        
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocation? = nil
    
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
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
