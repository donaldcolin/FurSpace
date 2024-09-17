//
//  UserProfileView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter { $0.user?.username == user.username }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                profileHeaderView(user: user)
                    .padding(.bottom, 1) // Add space between header and posts
                
                PostGridView(posts: posts)
                    .padding()
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: profileView()) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }}}
    }
}

#Preview {
    UserProfileView(user: User.MOCK_USER[3])
}
