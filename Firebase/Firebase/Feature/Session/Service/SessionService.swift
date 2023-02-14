//
//  SessionService.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum SessionState{
    case loggedIn
    case loggedOut
}

protocol SessionService{
var state: SessionState {get}
var userDetails: SessionUserDetails? { get }
func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService{
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        setupfirebaseAuthHandler()
        
    }
    
    func logout() {
       try? Auth.auth().signOut()
    }
    
}


private extension SessionServiceImpl{
    
    func setupfirebaseAuthHandler(){
        handler = Auth
            .auth()
            .addStateDidChangeListener{[weak self] res, User in
                guard let self = self else { return}
                self.state = User == nil ? .loggedOut : .loggedIn
                if let uid = User?.uid{
                    self.handleRefresh(with: uid)
                }
    
            }
    }


func handleRefresh(with uid: String){
    
    Database
        .database()
        .reference()
        .child("users")
        .child(uid)
        .observe(.value){ [weak self] snapshot in
            
            guard let self = self,
                  let value = snapshot.value as? NSDictionary,
                  let firstName = value[RegistrationKeys.firstName.rawValue] as? String,
                  let lastName = value[RegistrationKeys.lastName.rawValue] as? String,
                  let occupation = value[RegistrationKeys.occupation.rawValue] as? String else{
                return
            }
            DispatchQueue.main.async {
                self.userDetails = SessionUserDetails(firstName: firstName,
                                                      lastName: lastName,
                                                      occupation: occupation)
            }
        }
    }
}
