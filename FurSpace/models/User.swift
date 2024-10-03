import Foundation
import SwiftUI
import MapKit
import Firebase
import FirebaseAuth

// MARK: - User Model
struct User: Identifiable, Hashable, Codable, Equatable {
    let id: String
    var username: String?
    var profileimageurl: String?
    let email: String
    var fullname: String?
    var bio: String?
    var coordinate: CLLocationCoordinate2D

    // Computed property to check if the current user is the logged-in user
    var IscurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
    
    // Manual decoding for coordinate
    enum CodingKeys: String, CodingKey {
        case id, username, profileimageurl, email, fullname, bio, latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        profileimageurl = try container.decodeIfPresent(String.self, forKey: .profileimageurl)
        email = try container.decode(String.self, forKey: .email)
        fullname = try container.decodeIfPresent(String.self, forKey: .fullname)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Manual encoding for coordinate
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(profileimageurl, forKey: .profileimageurl)
        try container.encode(email, forKey: .email)
        try container.encode(fullname, forKey: .fullname)
        try container.encode(bio, forKey: .bio)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
    
    // Default initializer
    init(id: String, username: String?, profileimageurl: String?, email: String, fullname: String?, bio: String?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.username = username
        self.profileimageurl = profileimageurl
        self.email = email
        self.fullname = fullname
        self.bio = bio
        self.coordinate = coordinate
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
        lhs.username == rhs.username &&
        lhs.profileimageurl == rhs.profileimageurl &&
        lhs.email == rhs.email &&
        lhs.fullname == rhs.fullname &&
        lhs.bio == rhs.bio &&
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }

    // Manual Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
        hasher.combine(profileimageurl)
        hasher.combine(email)
        hasher.combine(fullname)
        hasher.combine(bio)
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
    }
}

// Mock users data
extension User {
    static var MOCK_USER: [User] = [
        User(
            id: UUID().uuidString,
            username: "martha",
            profileimageurl: "luffy",
            email: "marsh@gmail.com",
            fullname: "Martha Wayne",
            bio: "Dark knight's mom",
            coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        ),
        User(
            id: UUID().uuidString,
            username: "dj",
            profileimageurl: "doggy",
            email: "marsh2@gmail.com",
            fullname: "Dwayne Bravo",
            bio: "I play for CSK",
            coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094)
        ),
        User(
            id: UUID().uuidString,
            username: "alfred",
            profileimageurl: "user_10",
            email: "marsh1@gmail.com",
            fullname: "Alfred Pennyworth",
            bio: "Dark knight's sidekick",
            coordinate: CLLocationCoordinate2D(latitude: 37.7949, longitude: -122.3994)
        ),
        User(
            id: UUID().uuidString,
            username: "bruce",
            profileimageurl: "user_16",
            email: "bruce@gmail.com",
            fullname: "Bruce Wayne",
            bio: "Dark knight rises",
            coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        )
    ]
}
