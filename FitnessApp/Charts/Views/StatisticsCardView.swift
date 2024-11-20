//
//  StatisticsCardView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 20/11/2024.
//

import SwiftUI

struct StatisticsCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }}



#Preview {
    StatisticsCardView(title: "Average", value: "2000")
}
