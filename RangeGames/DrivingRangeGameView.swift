//
//  DrivingRangeGameView.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//


import SwiftUI
import SwiftData

struct DrivingRangeGameView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    let targets: [Target]
    @State private var holes: [Hole] = []
    @State private var currentIndex = 0
    @State private var showSummary = false

    var body: some View {
        if showSummary {
            summaryView
        } else if holes.indices.contains(currentIndex) {
            currentHoleView
        }
    }

    var currentHole: Hole {
        holes[currentIndex]
    }

    var currentHoleView: some View {
        VStack(spacing: 20) {
            Text("Hole \(currentIndex + 1)/18")
                .font(.title2)

            Text(currentHole.targetName)
                .font(.title)
            Text("\(currentHole.targetDistance) yd")
                .foregroundColor(.secondary)

            Text("Safe Side: \(currentHole.safeSide.capitalized)")
                .foregroundColor(.green)
            Text("Penalty Side: \(currentHole.penaltySide.capitalized)")
                .foregroundColor(.red)

            Divider()

            ForEach(ShotResult.allCases) { result in
                Button(result.label) {
                    let hole = holes[currentIndex]
                    hole.score = result
                    if currentIndex == holes.count - 1 {
                        showSummary = true
                    } else {
                        currentIndex += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            if holes.isEmpty {
                holes = generateHoles(from: targets)
            }
        }
    }

    var summaryView: some View {
        VStack {
            Text("Game Summary")
                .font(.title)

            List {
                ForEach(holes, id: \.id) { hole in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(hole.targetName)
                            Text("\(hole.targetDistance) yd")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("Safe: \(hole.safeSide), Penalty: \(hole.penaltySide)")
                                .font(.caption2)
                        }
                        Spacer()
                        Text(hole.score?.label ?? "—")
                    }
                }
            }

            Text("Total Score: \(holes.compactMap { $0.score?.points }.reduce(0, +))")
                .font(.headline)

            Button("Done") {
                let game = GameSession(holes: holes)
                context.insert(game)
                dismiss()
            }
            .padding()
        }
    }

    func generateHoles(from targets: [Target]) -> [Hole] {
        var pool = targets.shuffled()
        var result: [Hole] = []

        for i in 0..<18 {
            if pool.isEmpty { pool = targets.shuffled() }

            var pick = pool.removeFirst()

            // Avoid back-to-back same target
            while i > 0 && pick.targetID == result[i - 1].targetID {
                pool.append(pick)
                pick = pool.removeFirst()
            }

            let sides = Bool.random() ? ("left", "right") : ("right", "left")
            result.append(
                Hole(
                    targetID: pick.targetID,
                    targetName: pick.name,
                    targetDistance: pick.distance,
                    safeSide: sides.0,
                    penaltySide: sides.1
                )
            )
        }

        return result
    }

}
