//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 06/11/2024.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    let healthManager = HealthManager.shared
    @Published var calories: Int =  123
    @Published var exercise: Int =  23
    @Published var stand: Int =  3

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
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
//                healthManager.fetchTodayCaloriesBurned {result in
//                    switch result{
//                    case .success(let success):
//                        print(success)
//                    case .failure(let failure):
//                        print(failure.localizedDescription)
//                    }
//                }
                
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()

            }
        }
        
//        
//        healthManager.fetchTodayStandHours {result in
//            switch result{
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
    }
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned{
            result in
            switch result{
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayStandHours(){
        healthManager.fetchTodayStandHours {result in
            switch result{
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = Int(hours)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

}
