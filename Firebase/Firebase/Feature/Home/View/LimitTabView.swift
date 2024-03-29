//
//  HomeView.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import SwiftUI

struct LimitTabView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State private var selectedDate = Date()
    let notify = NotificationHandler()
    let viewModel = ProfileViewModel()
    
    var body: some View {
        TabView {
            TimerView(score: Score())
                .tabItem{
                    Image(systemName: "clock.circle")
                    Text("Timer")
                }
            ReminderView(score: Score())
                .tabItem{
                    Image(systemName: "flag.checkered")
                    Text("Score")
                }
//            InfoView(score: Score())
            NewView()
                .tabItem{
                    Image(systemName: "house.circle")
                    Text("Home")
                }
            GameView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Break Time")
                }
            ProfileView1(viewModel: viewModel)
               // ProfileView()
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
