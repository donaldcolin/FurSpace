//
//  PostGridView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//
import SwiftUI
import Kingfisher

struct PostGridView: View {

    @StateObject var viewmodel:PostGridViewmodel
    init(user:User){
        self._viewmodel = StateObject(wrappedValue: PostGridViewmodel(user: user))
    }
    
    let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(viewmodel.posts) { post in
                // Use the correct variable for accessing the imageURL property
                KFImage(URL(string: post.imageURL)) // Assuming these are local asset names
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}


