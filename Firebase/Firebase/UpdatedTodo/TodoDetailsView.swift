//
//  TodoDetailsView.swift
//  FirebaseTest
//
//  Created by swft on 5/10/23.
//

import SwiftUI

struct TodoDetailsView: View {
   @Environment(\.presentationMode) var presentationMode
   @State var presentEditTodoSheet = false
    
   var task: Todo1
    
   private func editButton(action: @escaping () -> Void) -> some View {
     Button(action: { action() }) {
       Text("Edit")
     }
   }
    
   var body: some View {
     Form {
       Section(header: Text("Task")) {
         Text(task.title)
         Text(task.description)
            
       }
        
     }
     .navigationBarTitle(task.title)
     .navigationBarItems(trailing: editButton {
       self.presentEditTodoSheet.toggle()
     })
     .onAppear() {
       print("TodoDetailsView.onAppear() for \(self.task.title)")
     }
     .onDisappear() {
       print("TodoDetailsView.onDisappear()")
     }
     .sheet(isPresented: self.$presentEditTodoSheet) {
       TodoEditView(viewModel: TodoViewModel(task: task), mode: .edit) { result in
         if case .success(let action) = result, action == .delete {
           self.presentationMode.wrappedValue.dismiss()
         }
       }
     }
   }
 }

struct TodoDetailsView_Previews: PreviewProvider {
   static var previews: some View {
       let task = Todo1(title: "Task", description: "this is a sample description")
       return
         NavigationView {
           TodoDetailsView(task: task)
         }
   }
}
