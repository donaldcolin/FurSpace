//
//  UserService.swift
//  FurSpace
//
//  Created by Donald Colin on 30/09/24.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchUser(withuid uid : String) async throws ->User{
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
        
        
    }
    
    static func fetchAllUsers() async throws ->[User]{
    
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        _ = snapshot.documents
        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    
    }
    static func fetchpet(withuid uid : String) async throws ->Pets{
        let snapshot = try await Firestore.firestore().collection("pets").document(uid).getDocument()
        return try snapshot.data(as: Pets.self)
        
        
    }
    
    
}
