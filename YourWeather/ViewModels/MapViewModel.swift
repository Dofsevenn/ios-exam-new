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

/*
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
/*
// Andre forsøk, tilpasset swiftui
struct MapViewTest2: UIViewRepresentable {
//@State private var annotation = MKPointAnnotation()
@State var annotations: [MKPointAnnotation]
let addAnnotationListener: (MKPointAnnotation) -> Void

func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let longPressed = UILongPressGestureRecognizer(target: context.coordinator,
                                                       action: #selector(context.coordinator.addPinBasedOnGesture(_:)))
        mapView.addGestureRecognizer(longPressed)
        return mapView
}

func updateUIView(_ view: MKMapView, context: Context) {
    view.delegate = context.coordinator
    view.addAnnotations(annotations)
    if annotations.count == 1 {
        let coords = annotations.first!.coordinate
        let region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        view.setRegion(region, animated: true)
    }

}
    
func makeCoordinator() -> MapViewCoordinator {
    MapViewCoordinator(self)
}

    class MapViewCoordinator: NSObject, MKMapViewDelegate {

    var mapViewController: MapViewTest2

    init(_ control: MapViewTest2) {
        self.mapViewController = control
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation
        guard let placemark = annotation as? MKPointAnnotation else { return }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        //Custom View for Annotation
        let identifier = "Placemark"
        if  let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            let button = UIButton(type: .infoDark)
            annotationView.rightCalloutAccessoryView = button
            return annotationView
        }
    }
        
        @objc func addPinBasedOnGesture(_ gestureRecognizer:UIGestureRecognizer) {
            let touchPoint = gestureRecognizer.location(in: gestureRecognizer.view)
            let newCoordinates = (gestureRecognizer.view as? MKMapView)?.convert(touchPoint, toCoordinateFrom: gestureRecognizer.view)
            let annotation = MKPointAnnotation()
            guard let _newCoordinates = newCoordinates else { return }
            annotation.coordinate = _newCoordinates
            mapViewController.annotations.append(annotation)
        }
    }
}*/


    
// Første forsøk, får opp kart, men da jeg prøvde å sett inn set region gikk det ikke på første forsøk.
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
    @Binding var annotation: MKPointAnnotation
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = WrappedMap()
        mapView.delegate = context.coordinator
        mapView.onLongPress = addAnnotation(for:)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //let region = locationManager.region.center
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
 
        let center = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
        let region = MKCoordinateRegion(center: center, span: span)
        uiView.setRegion(region, animated: true)
        
        
        print(annotationLat)
    }
    func addAnnotation(for coordinate: CLLocationCoordinate2D) {
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = coordinate
        annotation = newAnnotation
        
        setAnnotationsCoordinates(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        print(annotation.coordinate.latitude)
        print(annotation.coordinate.longitude)
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

/*
struct MapViewTest_Previews: PreviewProvider {
    static var previews: some View {
        MapViewModel()
        .edgesIgnoringSafeArea(.all)
    }
}*/

