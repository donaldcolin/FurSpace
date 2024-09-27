import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
}

struct SwiftUiMap: View {
    // Load mock users from User model
    let users: [User] = User.MOCK_USER
    
    @State private var region = MKCoordinateRegion(
        center: .defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // State to track which user is selected
    @State private var selectedUser: User? = nil
    
    var body: some View {
        ZStack {
            // Map with annotations
            Map(coordinateRegion: $region, annotationItems: users) { user in
                MapAnnotation(coordinate: user.coordinate) {
                    Button(action: {
                        selectedUser = user
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
                if let firstUser = users.first {
                    region.center = firstUser.coordinate
                }
            }
            
            // Show user details card when a marker is tapped
            if let user = selectedUser {
                VStack {
                    Spacer() // Push the card to the bottom of the screen
                    
                    // Card view for selected user
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
                        }
                        .padding()
                        
                        Button(action: {
                            // Close the card
                            selectedUser = nil
                        }) {
                            Text("Close")
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
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    SwiftUiMap()
}
