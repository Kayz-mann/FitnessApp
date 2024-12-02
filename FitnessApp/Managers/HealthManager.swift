//
//  HealthManager.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 06/11/2024.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        let calendar =  Calendar.current
        return calendar.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components =  calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        return calendar.date(from: components) ?? Date()
    }
    
    func fetchMonthStartAndEndDate() -> (Date, Date) {
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self))
        let startDate = calendar.date(from: startDateComponent) ?? self
        
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? self
        return (startDate, endDate)
    }
    
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM d"
        return formatter.string(from: self)
    }
}

extension Double {
    func formattedNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

class HealthManager {
    
    static let shared =  HealthManager()
    let healthStore = HKHealthStore()
    
    private init() {

        Task{
            do{
                try await requestHealthKitAccess()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let healthTypes: Set =  [calories, exercise, stand, steps]


        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }

    
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate =  HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query =  HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity =  results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            let calorieCount =  quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate =  HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query =  HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity =  results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            let exerciseCount =  quantity.doubleValue(for: .kilocalorie())
            completion(.success(exerciseCount))
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping (Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }

            let standCount = samples.filter { $0.value == HKCategoryValueAppleStandHour.stood.rawValue }.count
            completion(.success(standCount))
        }

        healthStore.execute(query)
    }
    
    //MARK Fitness Activity
    func fetchTodaySteps(completion: @escaping(Result<Activity, Error>) -> Void) {
        let steps =  HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query =  HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity =  results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            let steps = quantity.doubleValue(for: .count())
            let activity =  Activity(id: 0, title: "Today Steps", subtitle: "Goal: 800", image: "figure.walk", tintColor: .green, amount: steps.formattedNumberString())
            completion(.success(activity))
        }
        
        healthStore.execute(query)
    }
    
    
    func fetchCurrentWeekWorkoutStats(completion: @escaping (Result<[Activity], Error>) -> Void) {
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {[weak self] _, results, error in
            guard let workouts =  results as? [HKWorkout], error ==  nil else {
                completion(.failure(NSError()))
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var stairsCount: Int = 0
            var kickBoxingCount: Int = 0
            
        
            for workout in workouts {
                let duration = Int(workout.duration)/60
                if workout.workoutActivityType == .running {
                    runningCount += duration
                }else if workout.workoutActivityType == .traditionalStrengthTraining {
                    strengthCount  += duration
                } else if workout.workoutActivityType == .soccer {
                    soccerCount += duration
                } else if workout.workoutActivityType == .basketball {
                    basketballCount += duration
                } else if workout.workoutActivityType == .kickboxing {
                    kickBoxingCount += duration
                }
            }
            
            completion(.success(self?.generateActivitiesFromDurations(running: runningCount, strength: strengthCount, soccer: soccerCount, basketball: basketballCount, stairs: stairsCount, kickboxing: kickBoxingCount) ?? []))
        }
        healthStore.execute(query)
    }
    
    func generateActivitiesFromDurations(running: Int, strength: Int, soccer: Int, basketball: Int, stairs: Int, kickboxing: Int) -> [Activity] {
        return [
            Activity(id: 1, title: "Running", subtitle: "This week", image: "figure.run", tintColor: .green, amount: "\(running)"),
            Activity(id: 2, title: "Strength Training", subtitle: "This week", image: "dumbell", tintColor: .blue, amount: "\(strength)"),
            Activity(id: 3, title: "Soccer", subtitle: "This week", image: "figure.soccer", tintColor: .indigo, amount: "\(soccer)"),
            Activity(id: 4, title: "Basketball", subtitle: "This week", image: "figure.basketball", tintColor: .red, amount: "\(basketball)"),
            Activity(id: 5, title: "Stairstepper", subtitle: "This week", image: "figure.stairs", tintColor: .brown, amount: "\(stairs)"),
            Activity(id: 6, title: "Kickboxing", subtitle: "This week", image: "figure.kickboxing", tintColor: .cyan, amount: "\(kickboxing)"),



        ]
    }
    
    // MARK: Recent Workouts
    func fetchWorkoutsForMonth(month: Date, completion: @escaping (Result<[Workout], Error>) -> Void) {
        // Example start and end dates for the given month
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: month)),
              let endDate = calendar.date(byAdding: .month, value: 1, to: startDate) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let workoutsType = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: workoutsType, predicate: predicate, limit: 10, sortDescriptors: [sortDescriptor]) { _, results, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let hkWorkouts = results as? [HKWorkout] else {
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
            
            let workoutArray = hkWorkouts.map { workout in
                Workout(
                    id: nil, title: workout.workoutActivityType.name,
                    image: workout.workoutActivityType.image,
                    tintColor: workout.workoutActivityType.randomColor,
                    duration: "\(Int(workout.duration) / 60)", // Convert seconds to minutes
                    date: workout.startDate.formatWorkoutDate(),
                    calories: workout.totalEnergyBurned?.doubleValue(for: HKUnit.kilocalorie()).formattedNumberString() ?? "0"
                )
            }
            
            completion(.success(workoutArray))
        }
        
        HKHealthStore().execute(query)
    }
    

    


}

extension HealthManager {
    struct YearChartDataResult {
        let ytd: [DailyStepModel]
        let onYear: [DailyStepModel]
        
    }
    func fetchYTDOneYearChartData(completion: @escaping (Result<YearChartDataResult, Error>) -> Void) {
//        let steps = HKQuantityType(.stepCount)
        guard let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
               completion(.failure(NSError(domain: "HealthManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not create step count type"])))
               return
           }
        let calendar = Calendar.current
        
        var oneYearMonths = [DailyStepModel]()
        var ytdMonths = [DailyStepModel]()
        
        for i in 0...11 {
            let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
            let (startOfMonth, endOfMonth) = month.fetchMonthStartAndEndDate()
            let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth)
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, results,
                error in
                guard let quantity = results?.sumQuantity(), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                
                let stepCount = Int(quantity.doubleValue(for: HKUnit.count()))
                
                if i == 0 {
                    oneYearMonths.append(DailyStepModel(date: month, count: Int(stepCount)))
                    ytdMonths.append(DailyStepModel(date: month, count: Int(stepCount)))
                } else {
                    oneYearMonths.append(DailyStepModel(date: month, count: Int(stepCount)))
                    if calendar.component(.year, from: month) == calendar.component(.year, from: Date()) {
                        ytdMonths.append(DailyStepModel(date: month, count: Int(stepCount)))

                    }
                }
                if i == 11 {
                    completion(.success(YearChartDataResult(ytd: ytdMonths, onYear: oneYearMonths)))
                }
            }
            healthStore.execute(query)
        }
    }
}
