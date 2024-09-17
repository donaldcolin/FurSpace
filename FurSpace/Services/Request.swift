//
//  Request.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

//
//  Request.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

import Foundation

struct Request: Identifiable, Hashable, Encodable {
    let id: String
    let ownerUID: String
    let caption: String
    let likes: Int
    let timestamp: Date
    let datefrom: Date
    let dateTo: Date
    var user: User?
    
    // Custom initializer to convert timestamp from String (if necessary)
    init(id: String, ownerUID: String, caption: String, likes: Int, imageURL: String, timestamp: String, datefrom: Date, dateTo: Date, user: User?) {
        self.id = id
        self.ownerUID = ownerUID
        self.caption = caption
        self.likes = likes
        // Assuming timestamp is passed in as a string and converted to Date for uniformity
        self.timestamp = Request.convertTimestamp(from: timestamp)
        self.datefrom = datefrom
        self.dateTo = dateTo
        self.user = user
    }
    
    // Function to convert string timestamp to Date
    static func convertTimestamp(from string: String) -> Date {
        // Placeholder logic; implement as needed.
        return Date()
    }
}

extension Request {
    static var MOCK_Request: [Request] = [
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "bitch, please", likes: 5, imageURL: "luffy", timestamp: "2 days ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[3]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "knock knock", likes: 5, imageURL: "post_11", timestamp: "10 hrs ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[0]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "gg, please", likes: 5, imageURL: "post_10", timestamp: "1 hr ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[1]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "slay, please", likes: 5, imageURL: "post_15", timestamp: "1096 hrs ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[2]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "new request", likes: 10, imageURL: "post_16", timestamp: "5 days ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[0]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "another request", likes: 3, imageURL: "post_17", timestamp: "2 weeks ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[1]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "yet another request", likes: 7, imageURL: "post_18", timestamp: "1 month ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[2]),
        .init(id: UUID().uuidString, ownerUID: UUID().uuidString, caption: "final request", likes: 12, imageURL: "post_19", timestamp: "3 days ago", datefrom: Date(), dateTo: Date().addingTimeInterval(86400), user: User.MOCK_USER[3])
    ]
}
