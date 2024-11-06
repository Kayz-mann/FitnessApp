//
//  WorkoutCard.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 05/11/2024.
//

import SwiftUI

struct Workout {
    let id: Int
    let title: String
    let image: String
    let tintColor: Color
    let duration: String
    let date: String
    let calories: String
}

struct WorkoutCard: View {
    @State var workout: Workout

    var body: some View {
        HStack{
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tintColor)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
            
            VStack(spacing: 16) {
                HStack{
                    Text(workout.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("\(workout.duration) mins")
                }
                
                HStack{
                    Text(workout.date)
                    Spacer()
                    Text("\(workout.calories) kcal")
                }
            }
        }.padding()
    }
}

#Preview {
    WorkoutCard(workout: Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51", date: "Aug 1", calories: "512"))
}
