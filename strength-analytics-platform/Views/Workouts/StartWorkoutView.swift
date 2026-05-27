//
//  StartWorkoutView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import SwiftUI

struct StartWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    let workoutTitle: String
    let startedAt: Date
    let onCollapse: () -> Void

    var body: some View {
        VStack {
            Button(action: collapseWorkout) {
                HStack {
                    Image(systemName: "chevron.down")
                        .font(.title3)

                    Text("Log Workout")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            HStack {
                VStack {
                    Text("Duration")
                        .font(.caption)
                    TimelineView(.periodic(from: startedAt, by: 1)) { context in
                        Text(formattedWorkoutElapsedTime(from: startedAt, to: context.date))
                            .font(.headline)
                            .monospacedDigit()
                    }
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Volume")
                        .font(.caption)
                    Text("0 lbs")
                        .font(.headline)
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Sets")
                        .font(.caption)
                    Text("0")
                        .font(.headline)
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 15)
            Divider()
            HStack {
                Text(workoutTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 8)
            Spacer()
        }
        .padding()
        .navigationTitle("Log Workout")
    }

    private func collapseWorkout() {
        onCollapse()
        dismiss()
    }
}

#Preview {
    StartWorkoutView(
        workoutTitle: "Empty Workout",
        startedAt: Date()
    ) {}
}
