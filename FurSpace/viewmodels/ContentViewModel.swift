


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
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var currentPet: Pets?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession
            .sink { [weak self] userSession in
                self?.userSession = userSession
                if let userId = userSession?.uid {
                    self?.fetchCurrentUser(userId: userId)
                    self?.fetchCurrentPet(userId: userId) // Fetch current pet data
                }
            }
            .store(in: &cancellables)
        
        service.$currentUser
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }
    
    private func fetchCurrentUser(userId: String) {
        // Fetch the current user from the database
        // Assuming UserService has a method to fetch user by ID
        Task {
            do {
                self.currentUser = try await UserService.fetchUser(withuid: userId)
            } catch {
                print("Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchCurrentPet(userId: String) {
        // Fetch the current pet data from the database
        // Assuming PetService has a method to fetch pet by owner ID
        Task {
            do {
                self.currentPet = try await PetService.fetchPet(forOwnerId: userId)
            } catch {
                print("Error fetching pet: \(error.localizedDescription)")
            }
        }
    }
}
