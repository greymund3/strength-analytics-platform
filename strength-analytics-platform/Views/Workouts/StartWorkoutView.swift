//
//  StartWorkoutView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import SwiftUI

struct StartWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showCancelConfirmation: Bool = false
    @State private var isExercisePickerPresented: Bool = false
    @State private var workoutExercises: [Exercise] = []

    let availableExercises: [Exercise] = [
        Exercise(name: "Bench Press", muscleGroups: "Chest", isUnilateral: false),
        Exercise(name: "Squat", muscleGroups: "Legs", isUnilateral: false),
        Exercise(name: "Dumbbell Row", muscleGroups: "Back", isUnilateral: true)
    ]
    let workoutTitle: String
    let startedAt: Date
    let onCollapse: () -> Void
    let onCancelWorkout: () -> Void

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
            
            if workoutExercises.isEmpty {
                VStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.system(size:75))
                        .padding(.vertical, 20)
                    Text("Get Started")
                        .font(.headline)
                    Text("Add an exercise to start your workout")
                        .font(.subheadline)
                    
                    workoutActionButtons
                }
            } else {
                VStack(spacing: 12) {
                    ForEach(workoutExercises) { exercise in
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            Text(exercise.muscleGroups)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.gray.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                workoutActionButtons
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Log Workout")
        .confirmationDialog(
            "Cancel Workout?",
            isPresented: $showCancelConfirmation,
            titleVisibility: .visible
        ) {
            Button("Cancel Workout", role: .destructive) {
                onCancelWorkout()
                dismiss()
            }
            Button("Keep Workout", role: .cancel) {}
        } message: {
            Text("This will remove the current empty workout.")
        }
        .fullScreenCover(isPresented: $isExercisePickerPresented) {
            ExercisePickerView(exercises: availableExercises) { exercise in
                workoutExercises.append(exercise)
                isExercisePickerPresented = false
            }
        }
    }
    
    private var workoutActionButtons : some View {
        HStack {
            Button(action:{
                isExercisePickerPresented = true
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Exercise")
                        .font(.headline)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(10)

            Button(action:{
                showCancelConfirmation = true

            }) {
                HStack {
                    
                    Text("Discard Workout")
                        .font(.headline)
                        .foregroundStyle(.red)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(10)
        }
    }

    private func collapseWorkout() {
        onCollapse()
        dismiss()
    }
}

#Preview {
    StartWorkoutView(
        workoutTitle: "Empty Workout",
        startedAt: Date(),
        onCollapse: {},
        onCancelWorkout: {}
    )
}
