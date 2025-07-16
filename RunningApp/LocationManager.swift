//
//  LocationManager.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()

    private let manager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    private var cancellables = Set<AnyCancellable>()

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5          // metres
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }

    func requestAuth() {
        manager.requestAlwaysAuthorization()
        if manager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
            manager.requestAlwaysAuthorization()
        }
    }

    func start() { manager.startUpdatingLocation() }
    func stop()  { manager.stopUpdatingLocation() }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
}
