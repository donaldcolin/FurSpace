


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
        // Observe the user session and fetch the user/pet data when available
        service.$userSession
            .sink { [weak self] userSession in
                self?.userSession = userSession
                if let userId = userSession?.uid {
                    // Fetch user and pet data once userSession is available
                    self?.fetchCurrentUser(userId: userId)
                    self?.fetchCurrentPet(ownerUID: userId)
                }
            }
            .store(in: &cancellables)
        
        // Observe the current user object from the AuthService
        service.$currentUser
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
        
        service.$currentPet
            .sink { [weak self] currentPet in
                self?.currentPet = currentPet
            }
            .store(in: &cancellables)
    }
    
    private func fetchCurrentUser(userId: String) {
        // Fetch the current user from the database using the UserService
        Task {
            do {
                self.currentUser = try await UserService.fetchUser(withuid: userId)
            } catch {
                print("Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchCurrentPet(ownerUID: String) {
        // Fetch the current pet data from the database using the ownerUID
        Task {
            do {
                if let pet = try await PetService.fetchPet(forOwnerId: ownerUID) {
                    self.currentPet = pet
                } else {
                    print("No pet found for this owner.")
                }
            } catch {
                print("Error fetching pet: \(error.localizedDescription)")
            }
        }
    }
}
