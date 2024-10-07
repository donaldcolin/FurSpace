import SwiftUI
import Kingfisher

struct FeedCellView: View {
    @State var post: Post
    let user: User // Assuming `user` is available in the view
    let onLikeTapped: () async throws -> Void // Closure for like functionality
    
    @State private var isZoomed: Bool = false // State to manage zoom mode

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User Info Section
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .small)
                }
                
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
            
            // Post Image with Zoom Functionality
            ZStack {
                KFImage(URL(string: post.imageURL))
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
                            
                            KFImage(URL(string: post.imageURL))
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
                // Like Button
                Button {
                    Task {
                        try? await onLikeTapped()
                    }
                } label: {
                    Image(systemName: post.liked?.contains(user.id) ?? false ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(post.liked?.contains(user.id) ?? false ? .red : .primary)
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
struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellView(post: Post.MOCK_POSTS[0], user: User.MOCK_USER[0]) {
            print("Like button tapped")
        }
    }
}
