//
//  MapViewModel.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 16/11/2020.
//
import MapKit
import SwiftUI
import Foundation
import CoreLocation
  
// Kikke på CLGeocoder og se om det er noe jeg trenger å ha med.
import Foundation
import MapKit
final class WrappedMap: MKMapView {
    var onLongPress: (CLLocationCoordinate2D) -> Void = { _ in }
    init() {
        super.init(frame: .zero)
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gestureRecognizer.minimumPressDuration = 0.8
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

import SwiftUI
import MapKit
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
        
        setAnnotationsCoordinates(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        weatherWM.fetchWeatherSymbolInfo()
        weatherWM.fetchWeatherDataAnnotation()
        weatherIcon = weatherWM.iconImageNextHour
        
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

