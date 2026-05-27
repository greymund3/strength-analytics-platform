//
//  WorkoutsView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import SwiftUI

struct WorkoutsView: View {
    @State private var isWorkoutPresented: Bool = false
    @State private var activeWorkoutStartedAt: Date?

    private let activeWorkoutTitle = "Empty Workout"

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    startOrOpenWorkout()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Start Empty Workout")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .foregroundStyle(Color.white)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 16)
                Spacer()
            }
            .navigationTitle("Workout")
            .safeAreaInset(edge: .bottom) {
                if let activeWorkoutStartedAt, !isWorkoutPresented {
                    ActiveWorkoutPill(
                        title: activeWorkoutTitle,
                        startedAt: activeWorkoutStartedAt
                    ) {
                        isWorkoutPresented = true
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.snappy, value: activeWorkoutStartedAt != nil)
        }
        .fullScreenCover(isPresented: $isWorkoutPresented) {
            if let activeWorkoutStartedAt {
                StartWorkoutView(
                    workoutTitle: activeWorkoutTitle,
                    startedAt: activeWorkoutStartedAt
                ) {
                    isWorkoutPresented = false
                }
            }
        }
    }

    private func startOrOpenWorkout() {
        if activeWorkoutStartedAt == nil {
            activeWorkoutStartedAt = Date()
        }

        isWorkoutPresented = true
    }
}

#Preview {
    WorkoutsView()
}
