//
//  ForgotPasswordService.swift
//  FirebaseTest
//
//  Created by swft on 2/10/23.
//

import Foundation
import Combine
import FirebaseAuth

protocol ForgotPasswordService{
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>
}

final class ForgotPasswordServiceImpl: ForgotPasswordService{
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>{
        
        Deferred{
            
            Future{ promise in
                
                Auth
                    .auth()
                    .sendPasswordReset(withEmail: email){ error in
                        
                        if let err = error{
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
                
            }
        }
        .eraseToAnyPublisher()
    }
}
