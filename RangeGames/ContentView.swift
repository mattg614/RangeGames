//
//  ContentView.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var targets: [Target]
    @State private var showingAddTarget = false

    var body: some View {
        NavigationStack {
            VStack {
                if targets.isEmpty {
                    ContentUnavailableView("No Targets", systemImage: "scope", description: Text("Tap + to add your first target"))
                } else {
                    List {
                        ForEach(targets) { target in
                            HStack {
                                Text(target.name)
                                Spacer()
                                Text("\(target.distance) yd")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                NavigationLink("Start Driving Range Game") {
                    DrivingRangeGameView(targets: targets)
                }                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(targets.count < 3)
            }
            .navigationTitle("Targets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddTarget = true
                    } label: {
                        Label("Add Target", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTarget) {
                AddTargetView()
            }
        }
    }
}
