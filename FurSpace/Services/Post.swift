import Foundation

struct Post: Identifiable, Hashable, Encodable {
    let id: String
    let ownerUID: String
    let caption: String
    let likes: Int
    let imageURL: String
    let timestamp: Date
    var user: User?
    
    // Custom initializer to convert timestamp from String (if necessary)
    init(id: String, ownerUID: String, caption: String, likes: Int, imageURL: String, timestamp: String, user: User?) {
        self.id = id
        self.ownerUID = ownerUID
        self.caption = caption
        self.likes = likes
        self.imageURL = imageURL
        // Assuming timestamp is passed in as a string and converted to Date for uniformity
        self.timestamp = Post.convertTimestamp(from: timestamp)
        self.user = user
    }
    
    // Function to convert string timestamp to Date
    static func convertTimestamp(from string: String) -> Date {
        // Assuming the string represents the format like "2 days ago", you can modify this logic.
        return Date() // Placeholder logic; implement as needed.
    }
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "bitch, please", likes: 5, imageURL: "luffy", timestamp: "2 days ago", user: User.MOCK_USER[3]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "knock knock", likes: 5, imageURL: "post_11", timestamp: "10 hrs ago", user: User.MOCK_USER[0]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "gg, please", likes: 5, imageURL: "post_10", timestamp: "1 hr ago", user: User.MOCK_USER[1]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "slay, please", likes: 5, imageURL: "post_15", timestamp: "1096 hrs ago", user: User.MOCK_USER[2])
    ]
}
