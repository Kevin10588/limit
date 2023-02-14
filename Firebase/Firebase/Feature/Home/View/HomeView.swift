//
//  HomeView.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
     
    
    
    var body: some View {
        
            VStack(alignment: .leading,
                   spacing: 400){
                
            
                
                VStack(alignment: .leading,
                       spacing: 16){
                    
                    Text("First Name:\(sessionService.userDetails?.firstName ?? "N/A")")
                    Text("Last Name: \(sessionService.userDetails?.lastName ?? "N/A")")
                    Text("Occupation: \(sessionService.userDetails?.occupation ?? "N/A")")
                    
                }
                ButtonView(title: "Logout"){
                    sessionService.logout()
                    
                }
                
            }
            
                   .padding(.horizontal, 16)
            
            
                   .navigationTitle(sessionService.userDetails?.firstName ??  "None")
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
