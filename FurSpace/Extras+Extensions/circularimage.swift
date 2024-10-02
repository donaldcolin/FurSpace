//
//  ProfileImageSize.swift
//  FurSpace
//
//  Created by Donald Colin on 02/10/24.
//


import Kingfisher
import SwiftUI

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 120
        }
    }
}

struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize

    var body: some View {
        if let imageUrl = user.profileimageurl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .placeholder({ _ in
                    ProgressView()
                })
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USER[0], size: .large)
    }
}
