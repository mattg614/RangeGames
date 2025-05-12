//
//  Hole.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//

import Foundation
import SwiftData

@Model
class Hole {
    var targetID: UUID
    var targetName: String
    var targetDistance: Int
    var safeSide: String
    var penaltySide: String
    var scoreRaw: String?

    init(targetID: UUID, targetName: String, targetDistance: Int, safeSide: String, penaltySide: String, scoreRaw: String? = nil) {
        self.targetID = targetID
        self.targetName = targetName
        self.targetDistance = targetDistance
        self.safeSide = safeSide
        self.penaltySide = penaltySide
        self.scoreRaw = scoreRaw
    }

    var score: ShotResult? {
        get { scoreRaw.flatMap { ShotResult(rawValue: $0) } }
        set { scoreRaw = newValue?.rawValue }
    }
}
