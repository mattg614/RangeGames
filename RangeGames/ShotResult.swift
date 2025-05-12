//
//  ShotResult.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//


import Foundation

enum ShotResult: String, CaseIterable, Identifiable {
    case birdie, par, bogey, doubleBogey

    var id: String { self.rawValue }

    var label: String {
        switch self {
        case .birdie: return "Birdie"
        case .par: return "Par"
        case .bogey: return "Bogey"
        case .doubleBogey: return "Double"
        }
    }

    var points: Int {
        switch self {
        case .birdie: return -1
        case .par: return 0
        case .bogey: return 1
        case .doubleBogey: return 2
        }
    }
}
