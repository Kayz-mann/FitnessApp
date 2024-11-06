//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 06/11/2024.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    
    @State var calories: Int =  123
    @State var active: Int =  23
    @State var stand: Int =  3

    var mockActivities =  [
        Activity(id: 0, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9,000"),
        Activity(id: 1, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "9,000"),
        Activity(id: 2, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "9,000"),
        Activity(id: 3, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .orange, amount: "9,000"),

    ]
    
    var mockWorkouts
     =  [
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51", date: "Aug 1", calories: "512"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .green, duration: "51", date: "Aug 11", calories: "512"),
        Workout(id: 2, title: "Jumping", image: "figure.run", tintColor: .yellow, duration: "5", date: "Aug 21", calories: "512"),
        Workout(id: 3, title: "Planking", image: "figure.run", tintColor: .red, duration: "10", date: "Aug 1", calories: "512")
     ]

}
