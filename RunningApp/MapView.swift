//
//  MapView.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let locations: [CLLocation]

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        guard !locations.isEmpty else { return }

        let coords = locations.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(polyline)

        if coords.count == 1 {
            uiView.setRegion(MKCoordinateRegion(center: coords[0],
                                                latitudinalMeters: 500,
                                                longitudinalMeters: 500),
                             animated: true)
        } else {
            uiView.setVisibleMapRect(polyline.boundingMapRect,
                                     edgePadding: UIEdgeInsets(top: 20, left: 20,
                                                             bottom: 20, right: 20),
                                     animated: true)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView,
                     rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer() }
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 4
            return renderer
        }
    }
}
