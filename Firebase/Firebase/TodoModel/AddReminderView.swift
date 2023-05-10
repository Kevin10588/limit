//
//  AddReminderView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 4/26/23.
//

import SwiftUI

struct AddReminderView: View {
    @StateObject var viewModel = AddItemViewModel()
    
    @State private var selectedDate = Date()
    @State private var scheduledDates: [Date: Bool] = [:]
    let notify = NotificationHandler()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Assign Task", text: $viewModel.title)
                TextField("Description", text: $viewModel.description)
                
    
                //Spacer()
                DatePicker("Pick a date:", selection: $selectedDate, in: Date()... )
                Button("Schedule Reminder") {
                    if scheduledDates[selectedDate] != true {
                        notify.sendNotification(
                            date: selectedDate,
                            type: "date",
                            title: viewModel.title.isEmpty ? "Reminder" : viewModel.title,
                            body: viewModel.description);
                            scheduledDates[selectedDate] = true
                    }
                }
                
            }
            .navigationTitle("Create TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: viewModel.create)
                }
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
