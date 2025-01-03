//
//  HomeView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 01/11/2024.
//

import SwiftUI


struct HomeView: View {
    @StateObject var viewModel =  HomeViewModel()
    @State private var circleProgress: Int = 100
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading){
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()

                    
                    HStack{
                        Spacer()
                        
                        VStack{
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(viewModel.calories) kcal")
                                    .bold()
                            }.padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text("\(viewModel.exercise)mins")
                                    .bold()
                            }.padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Text("\(viewModel.stand) hours")
                                    .bold()
                            }

                        }
                        Spacer()
                        ZStack{
                            ProgressCricleView(progress: $viewModel.calories, goal: 600, color: .red)
                            ProgressCricleView(progress: $viewModel.exercise, goal: 60, color: .green).padding(.all, 20)
                            ProgressCricleView(progress: $viewModel.stand, goal: 12, color: .blue).padding(.all, 40)

                        }.padding(.horizontal)
                        
                        Spacer()
                    }.padding()
                    
                    HStack{
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button{
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                    }.padding(.horizontal)
                    
                    if viewModel.activities.isEmpty {
                        VStack {
                            Image(systemName: "figure.walk")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            
                            Text("No fitness activities today")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text("Keep moving to track your progress!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
//                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
//                            ForEach(viewModel.mockActivities, id: \.id) { activity in
//                                ActivityCard(activity: activity)
//                            }
//                        }.padding()
                    } else {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
                            ForEach(viewModel.activities, id: \.id) { activity in
                                ActivityCard(activity: activity)
                            }
                        }
                    }
                    
                    HStack{
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)

                        }
                    }.padding(.horizontal)
                    
                    LazyVStack{
                        ForEach(viewModel.workouts, id: \.id) {workout in
                            WorkoutCard(workout: workout)
                        }

                    }

                }
            }

        }
    }
}

#Preview {
    HomeView()
}
