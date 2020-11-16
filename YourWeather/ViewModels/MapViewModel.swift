//
//  MapViewModel.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 16/11/2020.
//
import MapKit
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
}
