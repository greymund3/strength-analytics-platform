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
    let exercises: [Exercise]
    let onSelectExercise: (Exercise) -> Void
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
                        ExercisePickerRow(exercise: exercise) {
                            onSelectExercise(exercise)
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action:{
                        
                    }) {
                        Text("Add")
                    }
                }
            }
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
    ) { exercise in
        print("Selected \(exercise.name)")
    }
}
