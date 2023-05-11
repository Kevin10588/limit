//
//  TodoVIewModel.swift
//  FirebaseTest
//
//  Created by swft on 5/10/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class TodoViewModel: ObservableObject {
   
  @Published var task: Todo1
  @Published var modified = false
    
 
  private var cancellables = Set<AnyCancellable>()
   
  init(task: Todo1 = Todo1(title: "", description: "")) {
    self.task = task
     
    self.$task
      .dropFirst()
      .sink { [weak self] task in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addTask(_ task: Todo1) {
    do {
      let _ = try db.collection("todolist").addDocument(from: task)
    }
    catch {
      print(error)
    }
  }
   
  private func updateTask(_ task: Todo1) {
    if let documentId = task.id {
      do {
        try db.collection("todolist").document(documentId).setData(from: task)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddTasks() {
    if let _ = task.id {
      self.updateTask(self.task)
    }
    else {
      addTask(task)
    }
  }
   
  private func removeTask() {
    if let documentId = task.id {
      db.collection("todolist").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddTasks()
  }
   
  func handleDeleteTapped() {
    self.removeTask()
  }
   
}
