//
//  SearchUserProfileView.swift
//  FurSpace
//
//  Created by Donald Colin on 05/10/24.
//


import SwiftUI

struct SearchUserProfileView: View {
    let user: User
    let pets: Pets
    // State variable to toggle between user and dog profile
    @State private var showingDogProfile: Bool = false
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter { $0.user?.username == user.username }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                if showingDogProfile {
                    // Show Dog profile
                    VStack {
                        Dogprofile(pest: pets, user: user)
                        // Add other dog-related profile info here if needed
                    }
                    .padding(.bottom, 1)
                } else {
                    // Show User Profile when the toggle is off
                    ProfileHeaderView(user: user)
                        .padding(.bottom, 1) // Add space between header and posts
                    
                    PostGridView(user:user)
                        .padding()
                }
            }
            
            // Floating Button to toggle between user and dog profile
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Toggle between user and dog profile
                        showingDogProfile.toggle()
                    }) {
                        Image(systemName: showingDogProfile ? "person.fill" : "pawprint.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SearchUserProfileView(user: User.MOCK_USER[1], pets: mockPets[0])
}
