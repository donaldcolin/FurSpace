//
//  FeedItem.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct FeedItem: Identifiable {
    let id = UUID()
    let isPost: Bool
    let content: String
}
