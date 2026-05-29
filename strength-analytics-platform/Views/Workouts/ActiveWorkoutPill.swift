//
//  ActiveWorkoutPill.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import SwiftUI

struct ActiveWorkoutPill: View {
    let title: String
    let startedAt: Date
    let onCancelWorkout: () -> Void
    let action: () -> Void

    @State private var showCancelConfirmation: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            Button(action: action) {
                HStack(spacing: 12) {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.title3)
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.white)
                        .background(.black)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        
                        TimelineView(.periodic(from: startedAt, by: 1)) { context in
                            Text(formattedWorkoutElapsedTime(from: startedAt, to: context.date))
                                .font(.subheadline)
                                .monospacedDigit()
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    Text("Current")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(.green)
                        .clipShape(Capsule())
                }
            }
            .buttonStyle(.plain)

            Button(action: {
                showCancelConfirmation = true
            }) {
                Image(systemName: "trash")
                    .font(.headline)
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.white)
                    .background(.red)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.regularMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.14), radius: 12, x: 0, y: 6)
        .confirmationDialog(
            "Cancel Workout?",
            isPresented: $showCancelConfirmation,
            titleVisibility: .visible
        ) {
            Button("Cancel Workout", role: .destructive, action: onCancelWorkout)
            Button("Keep Workout", role: .cancel) {}
        } message: {
            Text("This will remove the current empty workout.")
        }
    }
}

func formattedWorkoutElapsedTime(from startDate: Date, to currentDate: Date) -> String {
    let seconds = max(0, Int(currentDate.timeIntervalSince(startDate)))
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = seconds % 60

    if hours > 0 {
        return String(format: "%d:%02d:%02d", hours, minutes, remainingSeconds)
    }

    return String(format: "%d:%02d", minutes, remainingSeconds)
}

#Preview {
    ActiveWorkoutPill(
        title: "Empty Workout",
        startedAt: Date(),
        onCancelWorkout: {}
    ) {}
    .padding()
}
