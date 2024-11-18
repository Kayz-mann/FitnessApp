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

    @Published var activities = [Activity]()
    @Published var workouts =
    [
       Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51", date: "Aug 1", calories: "512"),
       Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .green, duration: "51", date: "Aug 11", calories: "512"),
       Workout(id: 2, title: "Jumping", image: "figure.run", tintColor: .yellow, duration: "5", date: "Aug 21", calories: "512"),
       Workout(id: 3, title: "Planking", image: "figure.run", tintColor: .red, duration: "10", date: "Aug 1", calories: "512")
    ]
    /*[Workout]()*/

    var mockActivities =  [
        Activity(id: 0, title: "Today steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "8990"),
        Activity(id: 1, title: "Today calories", subtitle: "Goal 10,000", image: "figure.walk", tintColor: .red, amount: "15500"),
        Activity(id: 2, title: "Running", subtitle: "This week", image: "figure.walk", tintColor: .blue, amount: "60 minutes"),
        Activity(id: 3, title: "Weight Lifting", subtitle: "This week", image: "figure.walk", tintColor: .orange, amount: "20 minutes"),

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
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaySteps()
                fetchRecentWorkouts()

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
        healthManager.fetchTodayCaloriesBurned { [weak self] result in
            switch result {
            case .success(let calories):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.calories = Int(calories)
                    let activity = Activity(
                        id: 1,
                        title: "Calories Burned",
                        subtitle: "today",
                        image: "flame",
                        tintColor: .red,
                        amount: calories.formattedNumberString()
                    )
                    // If you want to add the activity to your activities array
                    // self.activities.append(activity)
                }
            case .failure(let error):
                // More comprehensive error handling
//                print("Failed to fetch calories: \(error)")
                
                // Optional: More detailed logging
                if let localizedError = error as? LocalizedError {
                    print("Localized description: \(localizedError.localizedDescription)")
                }
                
                // Optional: Handle specific error types if applicable
                // switch error {
                //     case SomeSpecificErrorType:
                //         // Handle specific error
                //     default:
                //         break
                // }
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
//                print(failure.localizedDescription)
                print("failed to fetch exercise time")

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
    
    //MARK: Fitness Activity
    func fetchTodaySteps() {
        healthManager.fetchTodaySteps {
            result in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
//                    self.activities.append(activity)
                    self.activities = [
                                      activity,
                                      Activity(id: 2, title: "Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "10,000"),
                                      Activity(id: 3, title: "Distance", subtitle: "Today", image: "figure.walk", tintColor: .blue, amount: "5 km")
                                  ]
                }
                
                
            case .failure(let failure):
//                print(failure.localizedDescription)
                print("failed to fetch today steps")
            }
        }
    }
    
    
    //MARK: Fetch Recent Workouts

    func fetchRecentWorkouts() {
        healthManager.fetchWorkoutsForMonth(month: Date()) { result in
            switch result{
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts =  Array(workouts.prefix(4))                }
            case .failure(let failure):
//                print(failure.localizedDescription)
                print("Failed to fetch recent workouts")
            }
        }
    }
    

}
