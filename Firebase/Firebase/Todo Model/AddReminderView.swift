//
//  AddReminderView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 4/26/23.
//

import SwiftUI

struct AddReminderView: View {
    @StateObject var model = AddItemViewModel()
    
    @State private var selectedDate = Date()
    @State private var scheduledDates: [Date: Bool] = [:]
    let notify = NotificationHandler()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Assign Task", text: $model.title)
                TextField("Description", text: $model.description)
                
    
                //Spacer()
                DatePicker("Pick a date:", selection: $selectedDate, in: Date()... )
                Button("Schedule Reminder") {
                    if scheduledDates[selectedDate] != true {
                        notify.sendNotification(
                            date: selectedDate,
                            type: "date",
                            title: "Limit",
                            body: "Scheduled reminder!");
                            scheduledDates[selectedDate] = true
                    }
                }
                
            }
            .navigationTitle("Create TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: model.create)
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
