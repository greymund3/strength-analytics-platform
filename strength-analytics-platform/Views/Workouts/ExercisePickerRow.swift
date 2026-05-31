//
//  ExercisePickerRow.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/30/26.
//

import SwiftUI

struct ExercisePickerRow: View {
    let exercise: Exercise
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .background(.red)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        .foregroundStyle(.white)

                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .foregroundStyle(.white)
                            .font(.headline)
                        Text(exercise.muscleGroups)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()

                    if isSelected {
                        Text("Selected")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundStyle(.black)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                }
            }
            .buttonStyle(.plain)

            NavigationLink {
                ExerciseDetailView(exercise: exercise)
            } label: {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            .padding(10)
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.horizontal, 15)
        .background(.black)
        .overlay {
            Rectangle()
                .stroke(isSelected ? .green : .clear, lineWidth: 2)
        }
        .animation(.snappy, value: isSelected)
    }
}

#Preview {
    NavigationStack {
        ExercisePickerRow(
            exercise: Exercise(name: "Bench Press", muscleGroups: "Chest", isUnilateral: false),
            isSelected: true
        ) {}
    }
}
