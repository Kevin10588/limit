//
//  ModelCredentials.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import Foundation


struct LoginCredentials{
    var email: String
    var password:String
    
}

extension LoginCredentials{
    
    static var new: LoginCredentials{
        LoginCredentials(email: "",password: "")
    }
}



