//
//  NewView.swift
//  FirebaseTest
//
//  Created by swft on 5/10/23.
//

import SwiftUI
 
struct NewView: View {
     
    @StateObject var viewModel = TodosViewModel()
    @State var presentAddTodoSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddTodoSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func taskRowView(task: Todo1) -> some View {
       NavigationLink(destination: TodoDetailsView(task: task)) {
         VStack(alignment: .leading) {
           Text(task.title)
             .font(.headline)

         }
       }
    }
     
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.tasks) { task in
            taskRowView(task: task)
          }
          .onDelete() { indexSet in
        
            viewModel.removeTasks(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("To-Do")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("TodosListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddTodoSheet) {
          TodoEditView()
        }
         
      }
    }
}
 
 
struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
