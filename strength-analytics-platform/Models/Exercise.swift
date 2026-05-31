//
//  Exercise.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let muscleGroups: String
    let isUnilateral: Bool
}
