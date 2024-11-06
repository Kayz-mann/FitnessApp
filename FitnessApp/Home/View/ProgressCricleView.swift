//
//  ProgressCricleView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 04/11/2024.
//

import SwiftUI

// Add 'public' modifier to make the view accessible
public struct ProgressCricleView: View {
    // Also make these properties public
    @Binding public var progress: Int
    public var goal: Int
    public var color: Color
    private var width: CGFloat = 20
    

    public init(progress: Binding<Int>, goal: Int, color: Color) {
        self._progress = progress
        self.goal = goal
        self.color = color
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: width)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress) / CGFloat(goal))
                .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
        }
    }
}
 
#Preview {
    ProgressCricleView(progress: .constant(100), goal: 200, color: .red)
}
