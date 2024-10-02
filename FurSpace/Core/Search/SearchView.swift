import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(searchViewModel.filteredUsers(searchText: searchText)) { user in
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .small)
                                
                                VStack(alignment: .leading) {
                                    if let fullname = user.fullname {
                                        Text(fullname)
                                            .fontWeight(.semibold)
                                            .font(.footnote)
                                    } else {
                                        Text(user.username ?? "username")
                                            .fontWeight(.semibold)
                                            .font(.footnote)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .searchable(text: $searchText, prompt: "Search...")
            .navigationDestination(for: User.self) { user in
                UserProfileView(user: user)
                    .navigationBarBackButtonHidden()
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
