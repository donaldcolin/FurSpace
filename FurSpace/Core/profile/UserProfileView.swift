//
//  UserProfileView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct UserProfileView: View {
    let user: User

    // State variable to toggle between user and dog profile
    @State private var showingDogProfile: Bool = false
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter { $0.user?.username == user.username }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    if showingDogProfile, let pet = user.pets.first {
                        // Show Dog Profile when the toggle is on
                        Dogprofile(pest: pet)
                            .padding(.bottom, 1)
                    } else {
                        // Show User Profile when the toggle is off
                        profileHeaderView(user: user)
                            .padding(.bottom, 1) // Add space between header and posts
                        
                        PostGridView(posts: posts)
                            .padding()
                    }
                }
                
                // Floating Button to toggle views
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    UserProfileView(user: User.MOCK_USER[1])
}
