//
//  AddReminderView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 4/26/23.
//

import SwiftUI

struct AddReminderView: View {
    @StateObject var model = AddItemViewModel()

    var body: some View {
        NavigationView {
            Form {
                TextField("Assign Task", text: $model.title)
                TextField("Description", text: $model.description)
                
                Button("Create", action: model.create)
                
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
