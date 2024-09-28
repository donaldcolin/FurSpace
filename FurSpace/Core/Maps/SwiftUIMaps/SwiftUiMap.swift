import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
}

struct SwiftUiMap: View {
    @StateObject var viewModel = MapViewModel()
    @State private var showSearchBar = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D.defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // Track the user's location and compass
    @State private var userTrackingMode: MapUserTrackingMode = .none
    
    var body: some View {
        ZStack {
            // Map with annotations, compass, and user tracking mode
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.filteredUsers) { user in
                MapAnnotation(coordinate: user.coordinate) {
                    Button(action: {
                        viewModel.selectUser(user)
                    }) {
                        Image(systemName: "pawprint.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Optionally adjust the region to the first user's location
                if let firstUser = viewModel.users.first {
                    region.center = firstUser.coordinate
                }
            }
            .mapStyle(.standard) // Default map style
            .mapControls{
                MapCompass()
                MapUserLocationButton()
            }
            
            // Show user details card when a marker is tapped
            if let user = viewModel.selectedUser {
                userDetailCard(user: user)
            }

            // User location button
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Toggle user tracking mode to follow the user
//                        userTrackingMode = userTrackingMode == .follow ? .none : .follow
//                    }) {
//                        Image(systemName: "location.circle.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(.blue)
//                            .background(Color.white)
//                            .clipShape(Circle())
//                            .shadow(radius: 5)
//                    }
//                    .padding()
//                }
//            }
        }
        .safeAreaInset(edge: .top) {
            searchBar()
               
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .offset(x: showSearchBar ? 0 : -150)
        }
    }
    
    // Custom user detail card view
    private func userDetailCard(user: User) -> some View {
        VStack {
            Spacer() // Push the card to the bottom of the screen
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text(user.fullname ?? user.username)
                            .font(.headline)
                        Text(user.bio ?? "No bio available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()

                    // Dismiss button (X) at the top-right
                    Button(action: {
                        viewModel.deselectUser() // Deselect user (close card)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                .padding()

                // Message User Button
                Button(action: {
                    // Action to message the user
                }) {
                    Text("Message User")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.8)) // Translucent background
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
    
    // Custom search bar view
    private func searchBar() -> some View {
            HStack {
                if showSearchBar {
                    // Show the TextField when tapped
                    TextField("Search for a user", text: $viewModel.searchQuery)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .transition(.move(edge: .trailing)) // Smooth transition
                        .animation(.easeInOut, value: showSearchBar) // Animation when the search bar appears
                    
                    // Close button to hide the search bar
                    Button(action: {
                        withAnimation {
                            showSearchBar = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 8)
                    
                } else {
                    // Search icon when the search bar is not visible
                    Button(action: {
                        withAnimation {
                            showSearchBar = true
                        }
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(10)
        }
    }

#Preview {
    SwiftUiMap()
}
