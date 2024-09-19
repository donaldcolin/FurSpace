import Foundation
import SwiftUI
import MapKit

// MARK: - User Model
struct User: Identifiable, Hashable, Decodable, Encodable, Equatable {
    let id: String
    var username: String
    var profileimageurl: String?
    let email: String
    var fullname: String?
    var bio: String?
    let userType: String
    let coordinate: CLLocationCoordinate2D
    var followers: Int
    var following: Int
    var pets: [Pets] // Reference to Pets model

    // Manual decoding for coordinate and pets
    enum CodingKeys: String, CodingKey {
        case id, username, profileimageurl, email, fullname, bio, userType, latitude, longitude, followers, following, pets
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        profileimageurl = try container.decodeIfPresent(String.self, forKey: .profileimageurl)
        email = try container.decode(String.self, forKey: .email)
        fullname = try container.decodeIfPresent(String.self, forKey: .fullname)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        userType = try container.decode(String.self, forKey: .userType)
        followers = try container.decode(Int.self, forKey: .followers)
        following = try container.decode(Int.self, forKey: .following)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        pets = try container.decode([Pets].self, forKey: .pets) // Decode pets
    }
    
    // Manual encoding for coordinate and pets
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(profileimageurl, forKey: .profileimageurl)
        try container.encode(email, forKey: .email)
        try container.encode(fullname, forKey: .fullname)
        try container.encode(bio, forKey: .bio)
        try container.encode(userType, forKey: .userType)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
        
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        
        try container.encode(pets, forKey: .pets) // Encode pets
    }
    
    // Default initializer
    init(id: String, username: String, profileimageurl: String?, email: String, fullname: String?, bio: String?, userType: String, coordinate: CLLocationCoordinate2D, followers: Int, following: Int, pets: [Pets]) {
        self.id = id
        self.username = username
        self.profileimageurl = profileimageurl
        self.email = email
        self.fullname = fullname
        self.bio = bio
        self.userType = userType
        self.coordinate = coordinate
        self.followers = followers
        self.following = following
        self.pets = pets
    }

    // Manual Equatable conformance
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
               lhs.username == rhs.username &&
               lhs.profileimageurl == rhs.profileimageurl &&
               lhs.email == rhs.email &&
               lhs.fullname == rhs.fullname &&
               lhs.bio == rhs.bio &&
               lhs.userType == rhs.userType &&
               lhs.coordinate.latitude == rhs.coordinate.latitude &&
               lhs.coordinate.longitude == rhs.coordinate.longitude &&
               lhs.followers == rhs.followers &&
               lhs.following == rhs.following &&
               lhs.pets == rhs.pets
    }

    // Manual Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
        hasher.combine(profileimageurl)
        hasher.combine(email)
        hasher.combine(fullname)
        hasher.combine(bio)
        hasher.combine(userType)
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
        hasher.combine(followers)
        hasher.combine(following)
        hasher.combine(pets)
    }
}

// Mock users data
extension User {
    static var MOCK_USER: [User] = [
        .init(id: NSUUID().uuidString,
              username: "martha",
              profileimageurl: "luffy",
              email: "marsh@gmail.com",
              fullname: "martha wayne",
              bio: "dark knight's mom",
              userType: "Dog Owner",
              coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
              followers: 150,
              following: 100,
              pets: [mockPets[0]]), // Martha has one pet, Buddy
              
        .init(id: NSUUID().uuidString,
              username: "dj",
              profileimageurl: "doggy",
              email: "marsh2@gmail.com",
              fullname: "dwanye barvo",
              bio: "i play for csk",
              userType: "Dog Walker",
              coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094),
              followers: 200,
              following: 180,
              pets: [mockPets[1]]), // DJ has one pet, Whiskers
              
        .init(id: NSUUID().uuidString,
              username: "alfred",
              profileimageurl: "doggy",
              email: "marsh1@gmail.com",
              fullname: "bane",
              bio: "dark knight's sidekick",
              userType: "Dog Walker",
              coordinate: CLLocationCoordinate2D(latitude: 37.7949, longitude: -122.3994),
              followers: 300,
              following: 250,
              pets: [mockPets[2]]), // Alfred has one pet, Max
              
        .init(id: NSUUID().uuidString,
              username: "bruce",
              profileimageurl: "user_30",
              email: "bruce@gmail.com",
              fullname: "bruce wayne",
              bio: "dark knight rises",
              userType: "Dog Owner",
              coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
              followers: 600,
              following: 550,
              pets: [mockPets[3]]) // Bruce has one pet, Coco
    ]
}
