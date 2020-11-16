//
//  MapViewModel.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 16/11/2020.
//
/*import MapKit
import SwiftUI

struct MapViewModel: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewModel
        
        init(_ parent: MapViewModel) {
            self.parent = parent
        }
    }
} */

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
    @State var manager = CLLocationManager()
    @ObservedObject var locationManager = LocationManager()
    @State private var annotation = MKPointAnnotation()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = WrappedMap()
        mapView.delegate = context.coordinator
        mapView.onLongPress = addAnnotation(for:)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //let region = locationManager.region.center
        
        let center = CLLocationCoordinate2D(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: center, span: span)
        uiView.setRegion(region, animated: true)
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
    }
    func addAnnotation(for coordinate: CLLocationCoordinate2D) {
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = coordinate
        annotation = newAnnotation
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

struct MapViewTest_Previews: PreviewProvider {
    static var previews: some View {
        MapViewModel()
        .edgesIgnoringSafeArea(.all)
    }
}
