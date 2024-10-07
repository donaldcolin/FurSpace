//
//  PostGridViewmodel.swift
//  FurSpace
//
//  Created by Donald Colin on 05/10/24.
//

import Foundation

class PostGridViewmodel:ObservableObject{
    private let user: User
    @Published var posts = [Post]()
    
    
    init(user:User){
        self.user=user
        Task{try await fetchuserPosts()}
    }
    @MainActor
    func fetchuserPosts()async throws{
        
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        for i in 0..<posts.count{
            posts[i].user=self.user
            
            
        }
    }
}
