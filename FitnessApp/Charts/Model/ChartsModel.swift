//
//  ChartsModel.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 20/11/2024.
//

import Foundation


struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Double
}

enum ChartOptions: String, CaseIterable {
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonths = "3M"
    case yearToDate = "YTD"
    case oneYear = "1YR"
}
