import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .posts
    
    enum Tab {
        case posts
        case requests
    }
    
    // Assuming you have Post and Request models with mock data
    let posts: [Post] = Post.MOCK_POSTS
    let requests: [Request] = Request.MOCK_Request
    
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
                            ForEach(posts) { post in
                                FeedCellView(post: post)
                            }
                        }
                    }
                } else {
                    ScrollView {
                        VStack {
                            ForEach(requests) { request in
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
    CustomTabView()
}
