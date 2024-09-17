//
//  MessagingBubble.swift
//  FurSpace
//
//  Created by Donald Colin on 15/09/24.
//
import SwiftUI

struct MessagingBubble: View {
    var message: String
    var isCurrentUser: Bool
    var userImage: String
    
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading) {
            HStack {
                if isCurrentUser {
                    Spacer()
                }
                Text(message)
                    .padding()
                    .background(isCurrentUser ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                if !isCurrentUser {
                    Spacer()
                }
            }
            .padding(isCurrentUser ? .leading : .trailing, 50)
            .padding(.vertical, 5)
            
            Image(userImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .padding(isCurrentUser ? .leading : .trailing, 50)
        }
    }
}

#Preview {
    VStack {
        MessagingBubble(message: "Hello, how are you?", isCurrentUser: false, userImage: "luffy")
        MessagingBubble(message: "I'm good, thanks! How about you?", isCurrentUser: true, userImage: "doggy")
    }
    .padding()
}
