//
//  FeedViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 02/10/24.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var requests = [Request]()
    
    init() {
        Task {
            try await fetchposts()
        }
        Task {
            try await fetchrequests()
        }
    }
    
    @MainActor
    func fetchposts() async throws {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        self.posts = try snapshot.documents.compactMap { try $0.data(as: Post.self) }
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUID = post.ownerUID
            let postUser = try await UserService.fetchUser(withuid: ownerUID)
            posts[i].user = postUser
        }
    }
    
    @MainActor
    func fetchrequests() async throws {
        let snapshot = try await Firestore.firestore().collection("requests").getDocuments()
        self.requests = try snapshot.documents.compactMap { try $0.data(as: Request.self) }
        
        for i in 0 ..< requests.count {
            let request = requests[i]
            let ownerUID = request.ownerUID
            let requestUser = try await UserService.fetchUser(withuid: ownerUID)
            requests[i].user = requestUser
        }
    }
}
