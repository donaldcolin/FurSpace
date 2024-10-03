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
    @Published var currentUser: User?
    @Published var currentpet :Pets?
    init(){
        
        setupSubscribers()
    }
    
    func setupSubscribers(){
        serivice.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    
        serivice.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
        serivice.$currentpet.sink { [weak self] currentpet in
            self?.currentpet = currentpet
        }
        .store(in: &cancellables)
    }
}


