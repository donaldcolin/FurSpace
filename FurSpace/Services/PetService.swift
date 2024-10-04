import Foundation
import Firebase
import FirebaseFirestore


class PetService {
    
    static let petCollection = Firestore.firestore().collection("pets")

    // Fetch a single pet by owner ID
    static func fetchPet(forOwnerId ownerId: String) async throws -> Pets? {
        let snapshot = try await petCollection.whereField("ownerUID", isEqualTo: ownerId).getDocuments()

        // Check if there's at least one document returned
        guard let document = snapshot.documents.first else {
            print("No pets found for owner UID: \(ownerId)")
            return nil
        }

        // Try decoding the first document into a Pets object
        do {
            let pet = try document.data(as: Pets.self)
            return pet
        } catch {
            print("Error decoding pet data: \(error.localizedDescription)")
            throw error
        }
    }
}
