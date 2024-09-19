//
//  UserDetailsView.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

import SwiftUI

struct UserDetailsView: View {
    @State private var location: String = ""
    @State private var username : String = ""
    @State private var bio: String = ""
    @State private var profileImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    @EnvironmentObject var viewmodel: RegisterViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Please set up your profile")
                    .font(.title)
                    .bold()
                
                // Profile Image
                VStack {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            .shadow(radius: 10)
                    } else {
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $profileImage)
                }
                
                // Name TextField
                Text("Your name is **\(viewmodel.name)**")
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Text("Your email is \(viewmodel.email)")
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                
                // Location TextField
                TextField("Enter your location", text: $location)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Email TextField
                TextField("Enter your username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Bio TextField
                TextField("Write a bio about yourself and your furry friend", text: $bio)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Spacer()
                
                // Save Button
                NavigationLink(destination: PetQuestionnaireView()) {
                    Text("Save")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationBarTitle("Profile Setup", displayMode: .inline)
        }
    }
}

#Preview {
    UserDetailsView()
}
