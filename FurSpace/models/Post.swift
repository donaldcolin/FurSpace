import Foundation
import Firebase

struct Post: Identifiable, Hashable, Encodable {
    let id: String
    let ownerUID: String
    let caption: String
    let likes: Int
    let imageURL: String
    let timestamp: Timestamp
    var user: User?

}
    extension Post {
        static var MOCK_POSTS: [Post] = [
            .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "bitch, please", likes: 5, imageURL: "luffy", timestamp: Timestamp(), user: User.MOCK_USER[3]),  // 2 days ago
            .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "knock knock", likes: 5, imageURL: "dogphoto", timestamp: Timestamp(), user: User.MOCK_USER[0]),  // 10 hours ago
            .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "gg, please", likes: 5, imageURL: "dogpose", timestamp: Timestamp(), user: User.MOCK_USER[1]),  // 1 hour ago
            .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "slay, please", likes: 5, imageURL: "post_15", timestamp: Timestamp(), user: User.MOCK_USER[2])  // 1096 hours ago
        ]
    }
