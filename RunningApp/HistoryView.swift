//
//  HistoryView.swift
//  RunningApp
//
//  Created by mahesh lad on 15/07/2025.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @FetchRequest(entity: Run.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp,
                                                     ascending: false)])
    private var runs: FetchedResults<Run>

    var body: some View {
        NavigationStack {
            List {
                ForEach(runs) { run in
                    NavigationLink {
                        RunDetailView(run: run)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(run.timestamp!, formatter: dateFormatter)
                                .font(.headline)
                            Text(String(format: "%.2f km", run.distance / 1000))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteRun)
            }
            .navigationTitle("History")
        }
    }

    private func deleteRun(at offsets: IndexSet) {
        for index in offsets {
            let run = runs[index]
            PersistenceController.shared.delete(run: run)
        }
    }

    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }
}
