

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
            // Username at the top
            if let fullname = user.fullname {
                Text(fullname)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
            }
            
            // Profile picture and friends count
            HStack(spacing: 20) {
                Image(user.profileimageurl ?? "placeholder")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .shadow(radius: 10)
                
                Spacer()
                
                VStack {
                    Text("Friends")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("23")
                        .font(.title2)
                }
            }
            .padding(.horizontal)

            // Bio
            VStack(alignment: .leading, spacing: 4) {
                if let bio = user.bio {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // Add Friend Button
            HStack(spacing: 16) {
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
    }
}

#Preview {
    profileHeaderView(user: User.MOCK_USER[0])
}
