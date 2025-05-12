//
//  AddTargetView.swift
//  RangeGames
//
//  Created by Matthew Garza on 5/11/25.
//


import SwiftUI
import SwiftData

struct AddTargetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var distance = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Target Info") {
                    TextField("Name", text: $name)
                    TextField("Distance (yd)", text: $distance)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("New Target")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let distanceValue = Int(distance) {
                            let newTarget = Target(name: name, distance: distanceValue)
                            context.insert(newTarget)
                            dismiss()
                        }
                    }
                    .disabled(name.isEmpty || Int(distance) == nil)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
