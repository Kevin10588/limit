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
    
    private var cancellables = Set<AnyCancellable>()
    
    func create(){
        
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
