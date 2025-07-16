//
//  ActiveRunView.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI
import MapKit

struct ActiveRunView: View {
    @StateObject private var tracker = RunTracker()

    var body: some View {
        VStack(spacing: 32) {
            Text(String(format: "%.2f km", tracker.distance / 1000))
                .font(.system(size: 56, weight: .bold, design: .rounded))

            MapView(locations: tracker.currentLocations)
                .frame(height: 300)
                .cornerRadius(12)
                .padding(.horizontal)

            Spacer()

            Button(action: {
                switch tracker.state {
                case .stopped, .paused:
                    tracker.start()
                case .running:
                    tracker.stop()
                }
            }) {
                Text(tracker.state == .running ? "STOP" : "START")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(tracker.state == .running ? Color.red : Color.green)
                    .cornerRadius(12)
            }
            .padding()
        }
        .onAppear {
            LocationManager.shared.requestAuth()
        }
    }
}
