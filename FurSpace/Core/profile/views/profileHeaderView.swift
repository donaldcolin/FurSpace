

//
//  profileHeaderView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct profileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            // Username above the profile picture
//            if let username = user.username {
//                Text("@\(username)")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.primary)
//                    .padding(.top, 20)
//            }
            
            // Profile picture and name
            VStack(spacing: 8) {
                Image(user.profileimageurl ?? "placeHolders")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .shadow(color: .gray, radius: 10, x: 0, y: 4)
                
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
            
            // Friends and Posts stats
            HStack(spacing: 50) {
                statView(title: "Friends", count: "23")
                statView(title: "Posts", count: "42")
            }
            .padding(.horizontal)
            
            // Bio
            if let bio = user.bio {
                Text(bio)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Add Friend button
            Button(action: {
                // Add Friend action
            }) {
                Text("Add Friend")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
                .padding(.top, 16)
        }
        .background(
            Color(.systemBackground)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
        )
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // Helper function for the stats (Friends, Posts)
    private func statView(title: String, count: String) -> some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(count)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    profileHeaderView(user: User.MOCK_USER[0])
}
