//
//  FetchdogDetails.swift
//  FurSpace
//
//  Created by Donald Colin on 03/10/24.
//

//import Foundation
//import Firebase
//class FetchdogDetails :ObservableObject{
//    @Published var pets = [Pets]()
//
//    @MainActor
//    func fetchpets() async throws {
//        let snapshot = try await Firestore.firestore().collection("pets").getDocuments()
//        self.pets = try snapshot.documents.compactMap { try $0.data(as: Pets.self) }
//
//        for i in 0 ..< pets.count {
//            let post = pets[i]
//            let ownerUID = post.ownerUID
//            let postUser = try await UserService.fetchUser(withuid: ownerUID)
//            pets[i].user = postUser
//        }
//    }
//
//}
