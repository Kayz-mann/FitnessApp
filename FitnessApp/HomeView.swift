//
//  HomeView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 01/11/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Calories")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text("123 kcal")
                            .bold()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Calories")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text("123 kcal")
                            .bold()
                    }

                }
            }
        }
    }
}

#Preview {
    HomeView()
}
