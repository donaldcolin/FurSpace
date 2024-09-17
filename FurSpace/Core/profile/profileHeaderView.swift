

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
        VStack {
            // Profile picture, followers, and post count
            HStack(spacing: 20) {
                Image(user.profileimageurl ?? "placeholder")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .shadow(radius: 10)
                
                Spacer()
                
                VStack {
                    Text("Posts")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("120") // Example post count
                        .font(.title2)
                }
                VStack {
                    Text("Followers")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("\(user.followers)")
                        .font(.title2)
                }
                VStack {
                    Text("Following")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("\(user.following)")
                        .font(.title2)
                }
            }
            .padding(.horizontal)

            // Full name and bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.title2)
                        .fontWeight(.bold)
                                                }
                if let bio = user.bio {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                                   
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            // Edit Profile and Friends Button
            HStack(spacing: 16) {
                Button {
                    // Edit profile action
                } label: {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 36)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                }
                
                Button {
                    // Add Friends action
                } label: {
                    Text("Add Friend")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 36)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Divider()
                .padding(.top, 16)
        }
        .padding(.top, 20)
    }
}

#Preview {
    profileHeaderView(user: User.MOCK_USER[0])
}
