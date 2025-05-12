//
//  RangeGamesApp.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//

import SwiftUI
import SwiftData

@main
struct RangeGamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Target.self)
    }
}

