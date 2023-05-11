//
//  Todo.swift
//  FirebaseTest
//
//  Created by swft on 5/10/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Todo1: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var description: String

   
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description

  }
}
