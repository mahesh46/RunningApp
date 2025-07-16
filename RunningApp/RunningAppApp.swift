//
//  RunningAppApp.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI

@main
struct RunningApp: App {
    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistence.container.viewContext)
        }
    }
}
