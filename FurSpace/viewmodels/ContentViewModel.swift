//
//  ContentViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import Foundation
import FirebaseAuth
import Combine
@MainActor
class ContentViewModel: ObservableObject {
    
    private let serivice = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var userSession: FirebaseAuth.User?
    init(){
        
        setupSubscribers()
    }
    
    func setupSubscribers(){
        serivice.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
}


