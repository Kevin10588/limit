//
//  HomeView.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import SwiftUI

struct LimitTabView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl

    var body: some View {
        
        TabView {
            InfoView()
                .tabItem{
                    Image(systemName: "house.circle")
                    Text("Home")
                }
            TimerView()
                .tabItem{
                    Image(systemName: "clock.circle")
                    Text("Timer")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

struct LimitTabView_Previews: PreviewProvider {
    static var previews: some View {
            LimitTabView()
                .environmentObject(SessionServiceImpl())

    }
}
