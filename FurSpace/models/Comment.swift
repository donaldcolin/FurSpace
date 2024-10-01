//
//  Comment.swift
//  FurSpace
//
//  Created by Donald Colin on 01/10/24.
//


import Foundation


class Comment: Codable, Identifiable {
    var id: Int?
    var userid: Int?
    var username: String?
    var content: String?
    var createdAt: Date?

    
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case userid = "comment_userid"
        case username = "comment_username"
        case content = "comment_content"
        case createdAt = "comment_createdAt"

    }
    
    init(id: Int? = nil, userid: Int? = nil, username: String? = nil, content: String? = nil, createdAt: Date? = nil) {
        self.id = id
        self.userid = userid
        self.username = username
        self.content = content
        self.createdAt = createdAt

    }
}