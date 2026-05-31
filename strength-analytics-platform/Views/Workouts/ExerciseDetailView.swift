//
//  ExerciseDetailView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/30/26.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @State private var selectedTab: ExerciseDetailTab = .summary

    var body: some View {
        VStack(spacing: 16) {
            Picker("Exercise Detail", selection: $selectedTab) {
                ForEach(ExerciseDetailTab.allCases) { tab in
                    Text(tab.title).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            TabView(selection: $selectedTab) {
                ExerciseSummaryPage(exercise: exercise)
                    .tag(ExerciseDetailTab.summary)

                ExerciseHowToPage(exercise: exercise)
                    .tag(ExerciseDetailTab.howTo)

                ExerciseHistoryPage(exercise: exercise)
                    .tag(ExerciseDetailTab.history)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private enum ExerciseDetailTab: String, CaseIterable, Identifiable {
    case summary
    case howTo
    case history

    var id: Self {
        self
    }

    var title: String {
        switch self {
        case .summary:
            return "Summary"
        case .howTo:
            return "How To"
        case .history:
            return "History"
        }
    }
}

private struct ExerciseSummaryPage: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.name)
                .font(.title2)
                .fontWeight(.bold)

            Text(exercise.muscleGroups)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(exercise.isUnilateral ? "Unilateral exercise" : "Bilateral exercise")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

private struct ExerciseHowToPage: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How to perform")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Add coaching notes for \(exercise.name) here.")
                .foregroundStyle(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

private struct ExerciseHistoryPage: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("History")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Previous performance for \(exercise.name) will show here.")
                .foregroundStyle(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationStack {
        ExerciseDetailView(
            exercise: Exercise(name: "Bench Press", muscleGroups: "Chest", isUnilateral: false)
        )
    }
}
