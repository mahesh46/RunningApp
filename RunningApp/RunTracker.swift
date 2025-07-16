//
//  RunTracker.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import Combine
import CoreLocation

final class RunTracker: ObservableObject {
    enum State { case stopped, running, paused }

    @Published var state: State = .stopped
    @Published var distance: CLLocationDistance = 0
    @Published var currentLocations: [CLLocation] = []

    private var bag = Set<AnyCancellable>()
    private var lastLocation: CLLocation?

    init() {
        LocationManager.shared.$currentLocation
            .compactMap { $0 }
            .sink { [weak self] loc in
                guard let self = self else { return }
                if self.state == .running {
                    if let last = self.lastLocation {
                        self.distance += loc.distance(from: last)
                    }
                    self.lastLocation = loc
                    self.currentLocations.append(loc)
                }
            }
            .store(in: &bag)
    }

    func start() {
        state = .running
        distance = 0
        currentLocations.removeAll()
        lastLocation = nil
        LocationManager.shared.start()
    }

    func stop() {
        state = .stopped
        LocationManager.shared.stop()
        if !currentLocations.isEmpty {
            PersistenceController.shared.saveRun(distance: distance,
                                                 locations: currentLocations)
        }
    }
}
