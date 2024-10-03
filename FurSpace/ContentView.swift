//
//  ContentView.swift
//  FurSpace
//
//  Created by Donald Colin on 13/09/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registration = RegisterViewModel()

    var body: some View {

        Group{
            if  viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registration)
            } else if let currentUser = viewModel.currentUser {
                TabbarView(user: currentUser, pets: mockPets[1])
            }
        }
        }
    }


#Preview {
    ContentView()
}
