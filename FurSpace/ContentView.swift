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
                // Not logged in, show LoginView
                LoginView()
                    .environmentObject(registration)
            } else if let currentUser = viewModel.currentUser{ /*let currentPet = viewModel.currentPet {*/
                // If both user and pet data are available, show TabbarView
                        TabbarView(user: currentUser, pets: mockPets[0])
            } else {
                // Show loading view while fetching data
                VStack {
                    ProgressView("Loading...")
                    Text("User Session: \(viewModel.userSession != nil ? "Available" : "Not Available")")
                    Text("Current User: \(viewModel.currentUser != nil ? "Loaded" : "Not Loaded")")
                    Text("Current Pet: \(viewModel.currentPet != nil ? "Loaded" : "Not Loaded")")
                }
                .onAppear {
                    viewModel.setupSubscribers() // Ensure data fetching starts on view appear
                }
            }
        }
    }
}
