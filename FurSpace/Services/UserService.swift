//
//  UserService.swift
//  FurSpace
//
//  Created by Donald Colin on 30/09/24.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchAllUsers() async throws ->[User]{
    
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let documents = snapshot.documents
        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    
    }
    
    
}
