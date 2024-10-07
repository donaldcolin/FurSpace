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
        self.posts = try await PostService.fetchFeedPosts()
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
    
    @MainActor
       func toggleLike(postId: String, uid: String) async throws {
           try await PostService.toggleLike(postId: postId, uid: uid)
           let likedPostIndex = posts.firstIndex { post in
               post.id == postId
           }

           if let index = likedPostIndex {
               if posts[index].liked!.contains(uid) {
                   posts[index].likes -= 1
                   posts[index].liked!.removeAll(where: { $0 == uid })
               } else {
                   posts[index].likes += 1
                   posts[index].liked!.append(uid)
               }
           }
       }
   }

