//
//  ContentView.swift
//  strength-analytics-platform
//
//  Created by Reymundo Jr Guerrero on 5/26/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Placeholder-1")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Placeholder-2")
                .tabItem {
                    Label("Workout", systemImage: "figure.strengthtraining.traditional")
            }
            
            Text("Placeholder-3")
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            Text("Placeholder-4")
                .tabItem {
                    Label("Leaderboards", systemImage: "trophy")
                }
            
            Text("Placeholder-5")
                .tabItem {
                    Label("Profile", systemImage:"person.crop.circle")
                }
        }
       
        
    }
}

#Preview {
    ContentView()
}
