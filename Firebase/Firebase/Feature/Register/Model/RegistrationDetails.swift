//
//  RegistrationDetails.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import Foundation


struct RegistrationDetails{
    var email: String
    var password:String
    var firstName: String
    var lastName: String
    var occupation: String
    var parentEmail: String
    var description: String
    var title: String
}

extension RegistrationDetails{
    
   static var new: RegistrationDetails{
        RegistrationDetails(email: "",
                            password: "",
                            firstName: "",
                            lastName: "",
                            occupation: "",
                            parentEmail: "",
                            description: "",
                            title:"")
        
    }
}
