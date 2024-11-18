//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 04/11/2024.
//

import SwiftUI

struct ActivityCard: View {
    @State var activity: Activity

    
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 8){
                        Text(activity.title)
                            .font(.system(size: 16))
                        
                        Text(activity.subtitle)
                            .font(.system(size: 14)) // Custom font size
                            .foregroundColor(.gray) // Custom font color

                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(activity.tintColor)
                }
                
                Text("\(activity.amount)")
                    .font(.system(size: 18))
                    .bold()
                    .padding()
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.45)
        .padding()
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 0, title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9000"))
}
