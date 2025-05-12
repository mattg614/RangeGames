//
//  Target.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//

import Foundation
import SwiftData

@Model
class Target {
    var targetID: UUID
    var name: String
    var distance: Int

    init(targetID: UUID = UUID(), name: String, distance: Int) {
        self.targetID = targetID
        self.name = name
        self.distance = distance
    }
}
