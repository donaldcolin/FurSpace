//
//  MapViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 28/09/24.
//


import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var users: [User] = User.MOCK_USER // Load mock data
    @Published var selectedUser: User? = nil
    @Published var searchQuery: String = "" // To filter users by name
    
    // Logic to select a user when tapped
    func selectUser(_ user: User) {
        selectedUser = user
    }
    
    // Filter users based on the search query, searching both username and fullname
    var filteredUsers: [User] {
        if searchQuery.isEmpty {
            return users
        } else {
            return users.filter { user in
                let usernameMatches = user.username.lowercased().contains(searchQuery.lowercased())
                let fullNameMatches = user.fullname?.lowercased().contains(searchQuery.lowercased()) ?? false
                return usernameMatches || fullNameMatches
            }
        }
    }
    
    // Logic to deselect the user (close the card)
    func deselectUser() {
        selectedUser = nil
    }
}
