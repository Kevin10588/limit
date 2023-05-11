//
//  TodosViewModel.swift
//  FirebaseTest
//
//  Created by swft on 5/10/23.
//
import Foundation
import Combine
import FirebaseFirestore
 
class TodosViewModel: ObservableObject {
  @Published var tasks = [Todo1]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("todolist").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.tasks = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Todo1.self)
        }
      }
    }
  }
   
  func removeTasks(atOffsets indexSet: IndexSet) {
    let tasks = indexSet.lazy.map { self.tasks[$0] }
    tasks.forEach { task in
      if let documentId = task.id {
        db.collection("todolist").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
