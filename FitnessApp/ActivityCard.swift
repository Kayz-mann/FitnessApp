//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 04/11/2024.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let tintColor: Color
    let amount: String

}

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
                        
                        Text(activity.subtitle)
                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(activity.tintColor)
                }
                
                Text("\(activity.amount)")
                    .font(.title)
                    .bold()
                    .padding()
            }.padding()
        }.padding()
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 0, title: "Today Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9000"))
}