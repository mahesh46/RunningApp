//
//  ContentView.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ActiveRunView()
                .tabItem { Label("Run", systemImage: "figure.run") }

            HistoryView()
                .tabItem { Label("History", systemImage: "list.bullet") }
        }
    }
}

#Preview {
    let persistence = PersistenceController.shared
    ContentView()
        .environment(\.managedObjectContext,
                     persistence.container.viewContext)
}
