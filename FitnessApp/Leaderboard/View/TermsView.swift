//
//  TermsView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 11/01/2025.
//

import SwiftUI

struct TermsView: View {
    @State var name = ""
    @State var acceptedTerms =  false
    @AppStorage("username") var username: String?
    @Environment(\.dismiss) var dismiss


    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            TextField("Username", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                )
              
            
            HStack (alignment: .top){
                Button {
                    withAnimation {
                        acceptedTerms.toggle()
                    }
                    
                } label: {
                    if acceptedTerms {
                        Image(systemName: "square.inset.filled")
                    } else {
                        Image(systemName: "square")
                    }
                }
                
                Text("By checking you agree to the terms and enter into the leaderboard competititon")
            }
            
            Spacer()
            
            Button {
                if acceptedTerms && name.count > 2 {
                    username = name
                    dismiss()
                }
                
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }

        
        }.padding(.horizontal)
    }
}

#Preview {
    TermsView()
}
