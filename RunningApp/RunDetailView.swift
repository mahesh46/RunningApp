//
//  RunDetailView.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI
import CoreLocation

struct RunDetailView: View {
    let run: Run
    var locations: [CLLocation] { (run.locations as? [CLLocation]) ?? [] }
    
    var body: some View {
        NavigationView {
        VStack(spacing: 16) {
            Text(String(format: "%.2f km", run.distance / 1000))
                .font(.largeTitle.bold())
            
            MapView(locations: locations)
                .frame(maxHeight: .infinity)
        }
        .padding()
        .navigationTitle( "\(run.timestamp!, formatter: dateFormatter)")
    }
}

    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }
}
