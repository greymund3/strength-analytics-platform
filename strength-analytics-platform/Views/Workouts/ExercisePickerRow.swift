//
//  ExercisePickerRow.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/30/26.
//

import SwiftUI

struct ExercisePickerRow: View {
    let exercise: Exercise
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action) {
                HStack {
                    Image(systemName:"person")
                        .resizable()
                        .background(.red)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius:4)
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
                }
            }
            .buttonStyle(.plain)

            Button(action: {
                
            }) {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            .padding(10)
            .buttonStyle(.plain)
        }
        .frame(maxWidth:.infinity)
        .padding(.vertical, 30)
        .padding(.horizontal, 15)
        .background(.black)
        
        Divider()
    }
}

#Preview {
    ExercisePickerRow(
        exercise: Exercise(name: "Bench Press", muscleGroups: "Chest", isUnilateral: false)
    ) {}
}
