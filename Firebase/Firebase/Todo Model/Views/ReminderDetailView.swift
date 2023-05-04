//
//  ReminderDetailView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 4/26/23.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @State var title: String
    @State var description: String
    
    var body: some View {
        Text(description)
            .navigationTitle(title)
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderDetailView(title: "TEster", description: "due tomorrow")
        }
    }
}
