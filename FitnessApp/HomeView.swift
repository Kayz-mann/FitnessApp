//
//  HomeView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 01/11/2024.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int =  123
    @State var active: Int =  23
    @State var stand: Int =  3
    @State private var circleProgress: Int = 100
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
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
                            
                            Text("123 kcal")
                                .bold()
                        }.padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                            
                            Text("52 mins")
                                .bold()
                        }.padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stand")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                            
                            Text("8 hours")
                                .bold()
                        }

                    }
                    Spacer()
                    ZStack{
                        ProgressCricleView(progress: $calories, goal: 600, color: .red)
                        ProgressCricleView(progress: $active, goal: 60, color: .green).padding(.all, 20)
                        ProgressCricleView(progress: $stand, goal: 12, color: .blue).padding(.all, 40)

                    }.padding(.horizontal)
                    
                    Spacer()
                }.padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
