//
//  Petphoto.swift
//  FurSpace
//
//  Created by Donald Colin on 03/10/24.
//

import SwiftUI
import Kingfisher

struct PetPhoto: View {
    let pets: Pets
    
    var body: some View {
        if let imageUrl = pets.petimageurl, let url = URL(string: imageUrl) {
            KFImage(url)
                .resizable()
                .placeholder {
                    ProgressView() // Show a loading indicator while the image is loading
                }
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5) // Optional: Add shadow for better aesthetics
        } else {
            Image("vet") // Fallback image if no URL is provided
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5) // Optional: Add shadow for better aesthetics
        }
    }
    
    // Private computed properties for the view
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    private var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.30
    }
}

#Preview {
    // Provide a mock Pets object for the preview
    let mockPet = Pets(
        id: "1",
        ownerUID: "owner1",
        petimageurl: "", // Ensure this is a valid URL
        petname: "Buddy",
        activities: nil,
        age: 3,
        breed: "Golden Retriever",
        gender: "Male",
        type: "Dog",
        isPottyTrained: true,
        isSpayedNeutered: false,
        isFurnitureAllowed: true,
        user: nil
    )
    
    PetPhoto(pets: mockPet)
}
