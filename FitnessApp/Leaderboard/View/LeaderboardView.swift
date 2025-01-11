//
//  LeaderboardView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 11/01/2025.
//

import SwiftUI


struct LeaderboardUser: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let username: String
    let count: Int
}

class LeaderboardViewModel: ObservableObject {
    var mockData = [
        LeaderboardUser(id: 1, createdAt: "", username: "Kay", count: 2000),
        LeaderboardUser(id: 2, createdAt: "", username: "John Matt", count: 2300),
        LeaderboardUser(id: 3, createdAt: "", username: "Paul Hudson", count: 5300),
        LeaderboardUser(id: 4, createdAt: "", username: "Paul Hudson", count: 4300),
        LeaderboardUser(id: 5, createdAt: "", username: "Paul Hudson", count: 2600),
        LeaderboardUser(id: 6, createdAt: "", username: "Paul Hudson", count: 2655),
        LeaderboardUser(id: 7, createdAt: "", username: "Paul Hudson", count: 8655),





    ]
}

struct LeaderboardView: View {
    @StateObject var viewModel = LeaderboardViewModel()
    @AppStorage("username") var username: String?
    
    @Binding var showTerms: Bool
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            HStack{
                Text("Name")
                    .bold()
                
                Spacer()
                
                Text("Steps")
                    .bold()
            }
            .padding()
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.mockData) {
                    person in
                    HStack {
                        Text("\(person.id)")
                        Text(person.username)
                        Spacer()
                        Text("\(person.count)")
                    }
                    .padding(.horizontal)
                }
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showTerms) {
            TermsView()
        }
    }
}

#Preview {
    LeaderboardView(showTerms: .constant(false))
}
