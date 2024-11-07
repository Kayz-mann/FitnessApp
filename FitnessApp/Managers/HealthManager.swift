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
        let healthTypes: Set =  [calories, exercise, stand]


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
                completion(.failure(NSError()))
                return
            }

            let standCount = samples.filter { $0.value == HKCategoryValueAppleStandHour.stood.rawValue }.count
            completion(.success(standCount))
        }

        healthStore.execute(query)
    }
    


}
