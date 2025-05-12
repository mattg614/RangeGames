//
//  GameSession.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//


import Foundation
import SwiftData


@Model
class GameSession {
    var date: Date
    var holes: [Hole]
    var gameType: String

    init(date: Date = .now, holes: [Hole], gameType: String = "Driving Range") {
        self.date = date
        self.holes = holes
        self.gameType = gameType
    }

    var totalScore: Int {
        holes.compactMap { $0.score?.points }.reduce(0, +)
    }
}
