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
        if let imageUrl = pets.petimageurl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .placeholder({ _ in
                    ProgressView()
                })
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image("vet")
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
    
    PetPhoto(pets: mockPets[1])
}
