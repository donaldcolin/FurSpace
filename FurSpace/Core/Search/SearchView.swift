import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            HStack {
                                CircularProfileImageView(user: user, size: .xSmall)
                                VStack(alignment: .leading) {
                                    Text(user.username ?? "c")
                                        .fontWeight(.semibold)
                                    if let fullname = user.fullname {
                                        Text(fullname)
                                    }
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.top, 8)
            .searchable(text: $searchText, prompt: "Search...")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                UserProfileView(user: user)
            }
            .navigationTitle("Explore")
            
        }}}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
