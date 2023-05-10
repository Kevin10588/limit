//
//  FirebaseService.swift
//  FirebaseTest
//
//  Created by swft on 4/26/23.
//

import Foundation
import Combine
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


struct FirebaseService{
    
    static let db = Firestore.firestore()
    
    static func fetchTODOs() -> AnyPublisher< [TODOItem], Error>{
        Future<[TODOItem], Error>{ promise in
            self.db.collection("todos")
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        promise(.failure(error))
                        return
                        }
                        guard let snapshot = snapshot else {
                            promise(.failure(FirebaseError.badSnapshot))
                            return
                        }
                        
                        var items = [TODOItem]()
                    snapshot.documents.forEach { document in
                            if let item = try? document.data(as: TODOItem.self){
                            if items.contains(where: { $0.title == item.title}) { return }
                            items.append(item)
                        
                        }
                    }
                                                     promise(.success(items))
            }
        }
        
                .eraseToAnyPublisher()
      }
    static func create(_ todo: TODOItem) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.db.collection("todos")
                .addDocument(data: [
                    "title": todo.title,
                    "description": todo.description
                                    
                ]){ error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            
            
        }
        .eraseToAnyPublisher()
    }
    }
                                                     
