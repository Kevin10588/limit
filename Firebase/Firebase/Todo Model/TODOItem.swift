//
//  TODOItem.swift
//  FirebaseTest
//
//  Created by swft on 4/26/23.
//

import Foundation
struct TODOItem: Decodable, Identifiable {
    let id = UUID().uuidString
    
    let title: String
    let description: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: TODOItemKeys.self)
        
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
        
        
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

enum TODOItemKeys: String, CodingKey{
    case title
    case description
}
