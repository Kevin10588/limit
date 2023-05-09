//
//  AddItemViewModel.swift
//  FirebaseTest
//
//  Created by swft on 4/26/23.
//

import Foundation
import SwiftUI
import Combine
final class AddItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    
    @Published var alertItem: AlertItem?
    
    private var cancellables = Set<AnyCancellable>()
    
    var isValidForm: Bool {
        guard !title.isEmpty && !description.isEmpty else {
            alertItem = AlertContext.invalidform
            return false
        }
        
        return true
    }
    
    func create(){
        
        guard isValidForm else { return }
        
        let item = TODOItem(title: title, description: description)
        FirebaseService.create(item)
            .sink{ (completion) in
                switch completion{
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            
            }receiveValue: { _ in}
                .store(in: &cancellables)
    }
}
