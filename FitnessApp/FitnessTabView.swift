//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 01/11/2024.
//

import SwiftUI

struct FitnessTabView: View {
    @State var selectedTab =  "Home"
    
    init() {
// Creates a new UITabBarAppearance instance to customize the tab bar's visual
        let appearance = UITabBarAppearance()
// Sets the tab bar to have an opaque background (fully solid, no transparency)
        appearance.configureWithOpaqueBackground()
//Changes the color of the icon to green when a tab is selected
        appearance.stackedLayoutAppearance.selected.iconColor = .green
//Sets the text color to green for the selected tab's title
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.green]
//Applies the custom appearance configuration globally to all tab bars in the ap
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                Image(systemName: "house")
            }
            
            HistoricDataView()
                .tag("Historic")
                .tabItem {
                Image(systemName: "chart.line.uptrend.xyaxis")
            }
            
            
        }
    }
}

#Preview {
    FitnessTabView()
}