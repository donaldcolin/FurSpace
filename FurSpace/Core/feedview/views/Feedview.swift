import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .posts
    
    enum Tab {
        case posts
        case requests
    }
    
    @StateObject var viewmodel = FeedViewModel()
    let user: User

    var body: some View {
        NavigationView {
            VStack {
                // Custom Tab Bar
                HStack {
                    Spacer()
                    Button(action: {
                        selectedTab = .posts
                    }) {
                        VStack {
                            Text("Posts")
                                .foregroundColor(selectedTab == .posts ? .blue : .gray)
                            if selectedTab == .posts {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.blue)
                            } else {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        selectedTab = .requests
                    }) {
                        VStack {
                            Text("Requests")
                                .foregroundColor(selectedTab == .requests ? .blue : .gray)
                            if selectedTab == .requests {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.blue)
                            } else {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                
                // Content
                if selectedTab == .posts {
                    ScrollView {
                        VStack {
                            ForEach(viewmodel.posts) { post in
                                FeedCellView(post: post, user: user) {
                                    Task {
                                        try await viewmodel.toggleLike(postId: post.id, uid: user.id)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewmodel.requests) { request in
                                RequestCellView(request: request)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("FurSpace", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MessagingView()) {
                        Image(systemName: "message")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CustomTabView(user: User.MOCK_USER[0]) // Pass a mock user
}
