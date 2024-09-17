import SwiftUI

struct FeedCellView: View {
    let post: Post
    @State private var isZoomed: Bool = false // State to manage zoom mode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User Info Section
            HStack {
                Image(post.user?.fullname ?? "defaultProfileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(post.user?.username ?? "Unknown User")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(post.user?.fullname ?? "Unknown Location")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 8) {
                        TagView(text: "Dog owner", color: .blue)
                        TagView(text: "Dog walker", color: .red)
                        TagView(text: "Vet", color: .green)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // Caption
            Text(post.caption)
                .fontWeight(.regular)
                .font(.body)
                .lineLimit(3)
                .padding(.horizontal)
            
            // Time Info
            Text(post.timestamp, style: .relative)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Post Image with Zoom Functionality
            ZStack {
                Image(post.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(height: isZoomed ? nil : 400) // Adjust frame for zoom
                    .clipShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            isZoomed.toggle() // Toggle zoom state
                        }
                    }
                    .fullScreenCover(isPresented: $isZoomed) {
                        ZStack(alignment: .topTrailing) {
                            Color.black.edgesIgnoringSafeArea(.all)
                            
                            Image(post.imageURL)
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    withAnimation {
                                        isZoomed.toggle() // Dismiss zoom
                                    }
                                }
                            
                            Button(action: {
                                withAnimation {
                                    isZoomed.toggle() // Dismiss zoom
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
            }
            .padding(.horizontal)
            
            // Interaction Buttons
            HStack(spacing: 20) {
                Button {
                    print("likes")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                
                Button {
                    print("comment")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    print("share")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.primary)
            
            // Like Count
            Text("\(post.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            Divider()
        }
        .padding(.vertical)
    }
}

#Preview {
    FeedCellView(post: Post.MOCK_POSTS[0])
}
