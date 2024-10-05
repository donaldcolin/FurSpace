//
//  petimagecircle.swift
//  FurSpace
//
//  Created by Donald Colin on 05/10/24.
//

import Kingfisher
import SwiftUI

struct CircularPetImageView: View {
    let pet :Pets
    let size: ProfileImageSize

    var body: some View {
        if let imageUrl = pet.petimageurl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .placeholder({ _ in
                    ProgressView()
                })
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "pawprint.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct CircularPetImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularPetImageView(pet: mockPets[0], size: .large)
    }
}
