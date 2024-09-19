//
//  BasicDogInfoView.swift
//  FurSpace
//
//  Created by Donald Colin on 14/09/24.
//

import SwiftUI

struct BasicDogInfoView: View {
    let pets : Pets
    
    var dogBreed: String = "Golden Retriever" // Replace with dynamic breed
    var dogImage: String = "doggy" // Replace with dynamic dog image
    var petType: String = "Dog" // Replace with dynamic pet type
    var age: String = "3 years" // Replace with dynamic age
    var favoriteActivity: String = "Running in the park" // Replace with dynamic activity
    var isPottyTrained: Bool = true // Replace with dynamic potty training status
    var isVaccinated: Bool = true // Replace with dynamic vaccination status
    var furnitureAllowed: Bool = true // Replace with dynamic furniture allowance
    
    @State private var showExtraInfo: Bool = false // State for toggling extra info
    
    var body: some View {
        VStack {
            Spacer() // Push content to the bottom
            
            VStack(alignment: .leading, spacing: 5) {
                Text(pets.petname)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(pets.breed)
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                // Info button to show more details
                HStack {
                    Spacer() // Push the icon to the right
                    Button(action: {
                        // Toggle the extra info
                        withAnimation {
                            showExtraInfo.toggle()
                        }
                    }) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.4)) // Background for visibility
            .cornerRadius(10)
            .padding(.horizontal, 50)

            // Extra Information Section (Displayed above the name and breed)
            if showExtraInfo {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Pet Information")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Type: \(pets.type)")
                        .foregroundColor(.white)
                    
                    Text("Age: \(pets.age)")
                        .foregroundColor(.white)
                    
                    Text("Favorite Activity: \(pets.activities)")
                        .foregroundColor(.white)
                    
                    Text("Owner: Donald Colin") // Adjust or replace with dynamic owner name
                        .foregroundColor(.white)
                    
                    Text("Potty Trained: \(pets.isPottyTrained)")
                        .foregroundColor(.white)
                    
                    Text("Vaccinated: \(pets.age)")
                        .foregroundColor(.white)
                    
                    Text("Allowed on Furniture: \(pets.isFurnitureAllowed)")
                        .foregroundColor(.white)
                    
                    // Add more details as needed
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
                .transition(.move(edge: .bottom)) // Animation effect for showing extra info
            }
            
           
        }
        
        
    }
}

#Preview {
    BasicDogInfoView(pets: mockPets[0])
}
