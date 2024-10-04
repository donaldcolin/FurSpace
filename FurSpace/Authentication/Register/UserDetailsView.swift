//
//  UserDetailsView.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

import SwiftUI

struct UserDetailsView: View {
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedUIImage: UIImage? = nil // Store selected image as UIImage
    @EnvironmentObject var viewmodel: RegisterViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Please set up your profile")
                    .font(.title)
                    .bold()
                
                // Profile Image
                VStack {
                    if let selectedUIImage = selectedUIImage {
                        // If an image is selected, show it
                        Image(uiImage: selectedUIImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            .shadow(radius: 10)
                    } else {
                        // If no image is selected, show the button
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
                    ImagePicker(image: $selectedUIImage) // Use UIImage picker
                }
                
                // Name TextField
                Text("Your name is **\($viewmodel.fullname)**")
                    .padding()
                
                Text("Your email is \(viewmodel.email)")
                    .padding()
                    .background(Color(.systemGray6))
                // Username TextField
                TextField("Enter your username", text: $viewmodel.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                
                // Bio TextField
                TextField("Write a bio about yourself and your furry friend", text: $viewmodel.bio)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                 
                CustomButtonLocation(viewModel: viewmodel)
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
