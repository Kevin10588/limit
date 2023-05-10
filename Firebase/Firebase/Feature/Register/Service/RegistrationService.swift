//
//  RegistrationService.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import Foundation
import Combine
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


enum RegistrationKeys: String{
    case firstName
    case lastName
    case occupation
    case parentEmail
    case description
    case title
    case profileImageUrl
}

protocol RegistrationService{
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImpl: RegistrationService{
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>{
        
        
        Deferred{
            
            Future{ promise in
                
                Auth.auth()
                    .createUser(withEmail: details.email,
                                password: details.password){res, error in
                        
                        if let err = error{
                            promise(.failure(err))
                        } else {
                            if let uid = res?.user.uid{
                                
                                let values = [RegistrationKeys.firstName.rawValue: details.firstName,
                                              RegistrationKeys.lastName.rawValue: details.lastName,
                                              RegistrationKeys.parentEmail.rawValue: details.parentEmail,
                                              RegistrationKeys.description.rawValue: details.description,
                                              RegistrationKeys.title.rawValue: details.title,
                                              RegistrationKeys.profileImageUrl.rawValue: details.profileImageUrl,
                                              RegistrationKeys.occupation.rawValue: details.occupation] as [String : Any]
                                              
                                              
                                
                                Database.database()
                                    .reference()
                                    .child("users")
                                    .child(uid)
                                    .updateChildValues(values){error, ref in
                                        if let err = error{
                                            promise(.failure(err))
                                        } else{
                                            promise(.success(()))
                                        }
                                    }
                            
                            
                            
                            } else {
                                promise(.failure(NSError(domain: "Invaild User Id", code: 0, userInfo: nil)))
                            
                            }
                            
                            
                            
                            
                            
                        }
                    }
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}


