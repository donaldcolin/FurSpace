import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var pets = [Pets]()
    
    init() {
        Task {
            try await fetchAllUsersAndPets()
        }
    }
    
    @MainActor
    func fetchAllUsersAndPets() async throws {
        async let fetchedUsers = UserService.fetchAllUsers()
        async let fetchedPets = PetService.fetchAllPets()
        
        // Assign users and pets concurrently
        self.users = try await fetchedUsers
        self.pets = try await fetchedPets
    }
    
    // Function to fetch a pet for a specific user
    func pet(for user: User) -> Pets? {
        return pets.first(where: { $0.ownerUID == user.id })
    }
}
