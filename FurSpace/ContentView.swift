//
//  ContentView.swift
//  FurSpace
//
//  Created by Donald Colin on 13/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel() // Initialize ContentViewModel
    @StateObject var registration = RegisterViewModel() // Initialize RegisterViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                // If the user is not logged in, show the LoginView
                LoginView()
                    .environmentObject(registration)
            } else if let currentUser = viewModel.currentUser, let currentPet = viewModel.currentPet {
                // If both user and pet data are available, show the TabbarView
                TabbarView(user: currentUser, pets: currentPet)
            } else {
                // Show a loading indicator while fetching data
                VStack {
                    ProgressView("Loading...")
                    Text("User Session: \(viewModel.userSession != nil ? "Available" : "Not Available")")
                    Text("Current User: \(viewModel.currentUser != nil ? "Loaded" : "Not Loaded")")
                    Text("Current Pet: \(viewModel.currentPet != nil ? "Loaded" : "Not Loaded")")
                }
                .onAppear {
                    viewModel.setupSubscribers() // Ensure subscribers are set up on view appear
                }
            }
        }
    }
}
