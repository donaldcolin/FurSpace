//
//  profileView.swift
//  FurSpace
//
//  Created by Donald Colin on 13/09/24.
//

import SwiftUI

struct profileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Image with Edit Icon
                ZStack(alignment: .bottomTrailing) {
                    Image("luffy") // Replace with the actual user image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    // Edit Icon
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        )
                }
                
                // Name and Email
                VStack(spacing: 5) {
                    Text("Donald colin") // Replace with dynamic username
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Donaldcolin.com") // Replace with dynamic email
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Edit Profile Button
                Button(action: {
                    // Edit profile action
                }) {
                    Text("Edit Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                // Settings List
                VStack(spacing: 15) {
                    ProfileOptionRow(iconName: "gearshape", text: "Settings")
                    ProfileOptionRow(iconName: "creditcard", text: "Billing Details")
                    ProfileOptionRow(iconName: "person.2.fill", text: "User Management")
                    ProfileOptionRow(iconName: "info.circle.fill", text: "Information")
                    
                    // Logout Button
                    ProfileOptionRow(iconName: "arrowshape.turn.up.left.fill", text: "Logout", isDestructive: true)
                }
                .padding(.top, 20)
            }
            .padding(.top, 40) // Adjusts space for top padding
        }
    }
}

struct ProfileOptionRow: View {
    var iconName: String
    var text: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(isDestructive ? .red : .blue)
                .font(.title3)
                .frame(width: 35, height: 35)
                .background(isDestructive ? Color.clear : Color.blue.opacity(0.2))
                .clipShape(Circle())
            
            Text(text)
                .foregroundColor(isDestructive ? .red : .primary)
                .fontWeight(isDestructive ? .semibold : .regular)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    profileView()
}
