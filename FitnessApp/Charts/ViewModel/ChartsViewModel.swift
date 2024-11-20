//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 20/11/2024.
//

import Foundation


class ChartsViewModel: ObservableObject {
    @Published var selectedChartType: ChartOptions = .oneWeek
    
    // Mock Data Generation
    var oneWeekMockData: [DailyStepModel] {
        (0..<7).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Double.random(in: 8000...13000)
            )
        }
    }
    
    var oneMonthMockData: [DailyStepModel] {
        (0..<30).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Double.random(in: 8000...13000)
            )
        }
    }
    
    var threeMonthsMockData: [DailyStepModel] {
        (0..<90).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Double.random(in: 7000...14000)
            )
        }
    }
    
    var oneYearMockData: [DailyStepModel] {
        (0..<365).map { i in
            let baseCount = 10000.0
            let seasonalVariation = sin(Double(i) * .pi / 182.5) * 2000
            let randomVariation = Double.random(in: -1000...1000)
            let trendVariation = Double(i) * 5
            
            let count = max(baseCount + seasonalVariation + randomVariation + trendVariation, 5000)
            return DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: count
            )
        }
    }
    
    // Computed Properties for Statistics
    func getTotalSteps(for data: [DailyStepModel]) -> Int {
        Int(data.reduce(0) { $0 + $1.count })
    }
    
    func getAverageSteps(for data: [DailyStepModel]) -> Int {
        guard !data.isEmpty else { return 0 }
        return Int(data.reduce(0) { $0 + $1.count } / Double(data.count))
    }
    
    func getChartData() -> [DailyStepModel] {
        switch selectedChartType {
        case .oneWeek: return oneWeekMockData
        case .oneMonth: return oneMonthMockData
        case .threeMonths: return threeMonthsMockData
        case .yearToDate, .oneYear: return oneYearMockData
        }
    }
    
    func getChartXAxisUnit() -> Calendar.Component {
        switch selectedChartType {
        case .oneWeek, .oneMonth, .threeMonths: return .day
        case .yearToDate, .oneYear: return .month
        }
    }
}
