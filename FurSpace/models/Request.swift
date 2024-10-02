import Foundation
import Firebase

struct Request: Identifiable, Hashable, Codable {
    let id: String
    let ownerUID: String
    let caption: String
    let likes: Int
    let timestamp: Timestamp
    let datefrom: Date
    let dateTo: Date
    var user: User?
    
    // Custom initializer to handle Firebase Timestamp directly
   

    // Function to convert Firebase Timestamp to Date for use in the app
//    static func convertTimestampToDate(_ timestamp: Timestamp) -> Date {
//        return timestamp.dateValue()
//    }
}

extension Request {
    static var MOCK_Request: [Request] = [
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "bitch, please", likes: 5, timestamp: Timestamp(date: Date()), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[3]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "knock knock", likes: 5, timestamp: Timestamp(date: Date().addingTimeInterval(-36000)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[0]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "gg, please", likes: 5, timestamp: Timestamp(date: Date().addingTimeInterval(-3600)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[1]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "slay, please", likes: 5, timestamp: Timestamp(date: Date().addingTimeInterval(-360000)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[2]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "new request", likes: 10, timestamp: Timestamp(date: Date().addingTimeInterval(-432000)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[0]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "another request", likes: 3, timestamp: Timestamp(date: Date().addingTimeInterval(-1209600)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[1]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "yet another request", likes: 7, timestamp: Timestamp(date: Date().addingTimeInterval(-2592000)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[2]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "final request", likes: 12, timestamp: Timestamp(date: Date().addingTimeInterval(-259200)), datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[3])
    ]
}
