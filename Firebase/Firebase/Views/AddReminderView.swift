//
//  AddReminderView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 4/26/23.
//

import SwiftUI

struct AddReminderView: View {
    
    @State var title = ""
    @State var description = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("Assign Task", text: $title)
                TextField("Description", text: $description)
                
            }
            .navigationTitle("Create TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: {})
                }
            }
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
