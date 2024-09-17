//
//  PostGridView.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//
import SwiftUI

struct PostGridView: View {
    var posts: [Post]
    
    let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(posts) { post in
                // Use the correct variable for accessing the imageURL property
                Image(post.imageURL) // Assuming these are local asset names
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(posts: Post.MOCK_POSTS)
}
