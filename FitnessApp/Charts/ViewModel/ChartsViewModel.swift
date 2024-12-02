//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 20/11/2024.
//

import Foundation


class ChartsViewModel: ObservableObject {
    @Published var selectedChartType: ChartOptions = .oneWeek
    @Published var ytdChartData = [DailyStepModel]()
    @Published var oneYearChartData = [DailyStepModel]()
    
    @Published var ytdTotal: Int = 0
       @Published var oneYearTotal: Int = 0
       
       @Published var ytdAverage: Int = 0
       @Published var oneYearAverage: Int = 0
    
    let healthManager = HealthManager.shared
    
    init() {
        fetchYTDAndOneYearChartData()
    }
    
    // Mock Data Generation
    var oneWeekMockData: [DailyStepModel] {
        (0..<7).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Int.random(in: 8000...13000)
            )
        }
    }
    
    var oneMonthMockData: [DailyStepModel] {
        (0..<30).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Int.random(in: 8000...13000)
            )
        }
    }
    
    var threeMonthsMockData: [DailyStepModel] {
        (0..<90).map { i in
            DailyStepModel(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                count: Int.random(in: 7000...14000)
            )
        }
    }
    
    var oneYearMockData: [DailyStepModel] {
        (0..<365).map { i in
            let baseCount = 10000.0
            let seasonalVariation = sin(Double(i) * .pi / 182.5) * 2000
            let randomVariation = Double(Int.random(in: -1000...1000))
            let trendVariation = Double(i) * 5
            
            let count = Int(max(baseCount + seasonalVariation + randomVariation + trendVariation, 5000))
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
        return Int(data.reduce(0) { $0 + $1.count } / Int(data.count))
    }
    
    func getChartData() -> [DailyStepModel] {
        switch selectedChartType {
        case .oneWeek: return oneWeekMockData
        case .oneMonth: return oneMonthMockData
        case .threeMonths: return threeMonthsMockData
        case .yearToDate:
            return ytdChartData.isEmpty ? oneYearMockData : ytdChartData
        case .oneYear:
            return oneYearChartData.isEmpty ? oneYearMockData : oneYearChartData
        }
    }
    
    func getChartXAxisUnit() -> Calendar.Component {
        switch selectedChartType {
        case .oneWeek, .oneMonth, .threeMonths: return .day
        case .yearToDate, .oneYear: return .month
        }
    }
    
    func fetchYTDAndOneYearChartData() {
        healthManager.fetchYTDOneYearChartData{[weak self ] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.ytdChartData =  result.ytd
                    self?.oneYearChartData = result.onYear
                    
                    self?.ytdTotal = self?.ytdChartData.reduce(0, { $0 + $1.count } ) ?? 0
                    self?.oneYearTotal = self?.oneYearChartData.reduce(0, {$0 + $1.count}) ?? 0
                    
                    self?.ytdAverage = (self?.ytdTotal ?? 0) / Calendar.current.component(.month, from: Date())
                    self?.oneYearAverage =  (self?.ytdTotal ?? 0) / 12
                    
                }
            case .failure(let error):
                print("Error fetching chart data: \(error)")
                // Optionally set a default value or show an error state
                 DispatchQueue.main.async {
                     self?.ytdChartData = []
                     self?.oneYearChartData = []
                 }
            }
        }
    }
}
