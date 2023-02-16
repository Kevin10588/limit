//
//  LimitTabView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/14/23.
//

import SwiftUI

struct ProfileView: View {
    
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
