//
//  ContentViewModel.swift
//  FirebaseTest
//
//  Created by swft on 4/26/23.
//

import Foundation
import SwiftUI
import Combine

final class ContentViewModel: ObservableObject{
    
    private var cancellables = Set<AnyCancellable>()
    @Published var items = [TODOItem]()
    
    func loaditems(){
        FirebaseService.fetchTODOs()
            .sink{(completion) in
                switch completion{
                case .failure(let error):
                    print(error)
                    return
                case.finished:
                    return
                }
            } receiveValue: { [weak self](items) in
                self?.items = items
            }
            .store(in: &cancellables)
    }
}
