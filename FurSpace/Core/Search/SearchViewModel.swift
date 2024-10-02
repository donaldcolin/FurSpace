//
//  SearchViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 30/09/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchAllUsers()
        }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
    
    // Filtering logic for search
    func filteredUsers(searchText: String) -> [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                (user.username?.lowercased().contains(searchText.lowercased()))! ||
                (user.fullname?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
    }
}
