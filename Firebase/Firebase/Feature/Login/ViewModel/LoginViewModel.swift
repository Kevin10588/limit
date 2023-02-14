//
//  LoginViewModel.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import Foundation
import Combine

enum LoginState{
    case successfull
    case failed(error: Error)
    case na
}

protocol LoginViewModel{
    func login()
    var service: LoginService { get}
    var state: LoginState { get}
    var credentials: LoginCredentials { get }
    var hasError: Bool { get}
    init(Service: LoginService)
}


final class LoginViewModelImpl: ObservableObject, LoginViewModel{
    @Published var hasError: Bool = false
    
    @Published var state: LoginState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: LoginService
    
    init(Service: LoginService) {
        self.service = Service
        setupErrorSubscriptions()
    }
    
    
    func login(){
        
        service
            .login(with: credentials)
            .sink { res in
                
                switch res {
                case .failure(let err):
                    self.state = .failed(error: err)
                default: break
                }
            
            } receiveValue: {[weak self] in
                    self?.state = .successfull
    }
    .store(in: &subscriptions)
 }

}

private extension LoginViewModelImpl{
    
    func setupErrorSubscriptions(){
        $state
            .map { state -> Bool in
            switch state {
            case .successfull,
                    .na:
                return false
            case .failed:
                return true
            
            }
        }
        .assign(to: &$hasError)
    }
}

