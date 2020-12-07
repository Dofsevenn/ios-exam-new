//
//  MapViewModel.swift
//  YourWeather
//

import Combine
import MapKit
import SwiftUI
import Foundation
import CoreLocation

// Koden i denne filen er funnet på nettet og tilpasset til at det fungerer hos meg
// The code in this file is copy an paste from Stack Overflow, and modified to my project. But after I spilled water on may mac, and had to bye a new one, I can not find the place were I got the code from. But I hope it's enough that I confirms the most of the code in this file is copied from someone else.
// The @ObservedObject, @State, @Binding, the WeatherVM and the api call and weatherIcon is my code, the rest is copyed and modified.  

final class WrappedMap: MKMapView {
    var onLongPress: (CLLocationCoordinate2D) -> Void = { _ in }
    init() {
        super.init(frame: .zero)
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gestureRecognizer.minimumPressDuration = 0.5
        addGestureRecognizer(gestureRecognizer)
    }
    @objc func handleTap(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let location = sender.location(in: self)
            let coordinate = convert(location, toCoordinateFrom: self)
            onLongPress(coordinate)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MapViewModel: UIViewRepresentable {
    @ObservedObject var weatherWM = WeatherViewModel()
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    @Binding var annotation: MKPointAnnotation
    @Binding var weatherIcon: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = WrappedMap()
        mapView.delegate = context.coordinator
        mapView.onLongPress = addAnnotation(for:)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
        
    }
    
    func addAnnotation(for coordinate: CLLocationCoordinate2D) {
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = coordinate
        annotation = newAnnotation
        print("annotation coordinates")
        
        setAnnotationsCoordinates(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        weatherWM.fetchWeatherSymbolInfo()
        weatherWM.fetchWeatherDataAnnotation()
        
        // Had to use a timer here to wait for the api call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.weatherIcon = weatherWM.iconImageNextHour
        }
    
    }
}
extension MapViewModel {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewModel
        init(_ parent: MapViewModel) {
            self.parent = parent
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
} 

/* Commented out these when I didn't used it
struct MapViewTest_Previews: PreviewProvider {
    static var previews: some View {
        MapViewModel()
        .edgesIgnoringSafeArea(.all)
    }
}*/

