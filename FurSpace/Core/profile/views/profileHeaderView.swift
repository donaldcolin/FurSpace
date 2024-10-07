

//
//  profileHeaderView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile picture
            CircularProfileImageView(user: user, size: .large)
            
            // Full name
            if let fullname = user.fullname {
                Text(fullname)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
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
                Text(user.IscurrentUser ? "edit profile" : "Follow")
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
    ProfileHeaderView(user: User.MOCK_USER[0])
}
