//
//  ExercisePickerView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/29/26.
//

import SwiftUI

struct ExercisePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedExerciseIDs: Set<Exercise.ID> = []

    let exercises: [Exercise]
    let onAddExercises: ([Exercise]) -> Void
    
    private var selectedExercises: [Exercise] {
        exercises.filter { selectedExerciseIDs.contains($0.id) }
    }
    
    private var hasSelectedExercises: Bool {
        !selectedExercises.isEmpty
    }
    
    private var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exercises
        }

        return exercises.filter { exercise in
            exercise.name.localizedCaseInsensitiveContains(searchText)
                || exercise.muscleGroups.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredExercises) { exercise in
                        ExercisePickerRow(
                            exercise: exercise,
                            isSelected: selectedExerciseIDs.contains(exercise.id)
                        ) {
                            toggleExerciseSelection(exercise)
                        }
                    }
                }
            }
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Find exercise")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                        Button(action:{
                            dismiss()
                        }) {
                            Text("Cancel")
                        }
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                if hasSelectedExercises {
                    Button(action: addSelectedExercises) {
                        Text(addButtonTitle)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.snappy, value: selectedExerciseIDs.count)
        }
    }

    private var addButtonTitle: String {
        let count = selectedExerciseIDs.count
        return count == 1 ? "Add 1 Exercise" : "Add \(count) Exercises"
    }

    private func addSelectedExercises() {
        onAddExercises(selectedExercises)
        dismiss()
    }

    private func toggleExerciseSelection(_ exercise: Exercise) {
        if selectedExerciseIDs.contains(exercise.id) {
            selectedExerciseIDs.remove(exercise.id)
        } else {
            selectedExerciseIDs.insert(exercise.id)
        }
    }
}

#Preview {
    ExercisePickerView(
        exercises: [
            Exercise(name: "Bench Press", muscleGroups: "Chest", isUnilateral: false),
            Exercise(name: "Squat", muscleGroups: "Legs", isUnilateral: false),
            Exercise(name: "Dumbbell Row", muscleGroups: "Back", isUnilateral: true)
        ]
    ) { exercises in
        print("Selected \(exercises.map(\.name).joined(separator: ", "))")
    }
}
