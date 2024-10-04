//
//  PetService.swift
//  FurSpace
//
//  Created by Donald Colin on 04/10/24.
//
import Foundation
import Firebase
import FirebaseFirestore

class PetService {
    private let db = Firestore.firestore()

    // Fetch a pet by owner ID
    static func fetchPet(forOwnerId ownerId: String) async throws -> Pets? {
        let petsRef = Firestore.firestore().collection("pets")
        
        // Query to find the pet for the given owner ID
        let querySnapshot = try await petsRef.whereField("ownerUID", isEqualTo: ownerId).getDocuments()

        // Check if any documents were returned
        if querySnapshot.documents.isEmpty {
            print("No pets found for owner UID: \(ownerId)")
            return nil
        }
        
        // Decode the document into a Pets object
        guard let document = querySnapshot.documents.first else {
            print("Error: Failed to get the first document for owner UID: \(ownerId)")
            return nil
        }
        
        do {
            let pet = try document.data(as: Pets.self)
            print("Fetched pet: \(pet)")
            return pet
        } catch {
            print("Error decoding pet data: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Fetch all pets for a specific owner
    static func fetchAllPets(forOwnerId ownerId: String) async throws -> [Pets] {
        let petsRef = Firestore.firestore().collection("pets")
        
        // Query to find all pets for the given owner ID
        let querySnapshot = try await petsRef.whereField("ownerUID", isEqualTo: ownerId).getDocuments()

        // Check if any documents were returned
        if querySnapshot.documents.isEmpty {
            print("No pets found for owner UID: \(ownerId)")
            return []
        }

        // Decode all documents into an array of Pets objects
        let pets = try querySnapshot.documents.compactMap { try $0.data(as: Pets.self) }
        print("Fetched \(pets.count) pets for owner UID: \(ownerId)")
        return pets
    }
}
    // Add a new pet to the database
    //    static func addPet(_ pet: Pets) async throws {
    //        let petsRef = Firestore.firestore().collection("pets")
    //
    //        // Add the pet document to the collection
    //        let _ = try petsRef.addDocument(from: pet)
    //    }
    //
    //    // Update an existing pet
    //    static func updatePet(_ pet: Pets) async throws {
    //        let petsRef = Firestore.firestore().collection("pets").document(pet.id)
    //
    //        // Update the pet document
    //        try petsRef.setData(from: pet)
    //    }
    //
    //    // Delete a pet
    //    static func deletePet(petId: String) async throws {
    //        let petsRef = Firestore.firestore().collection("pets").document(petId)
    //
    //        // Delete the pet document
    //        try petsRef.delete()
    //    }
    //}

