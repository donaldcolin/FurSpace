//
//  RequestcellView.swift
//  FurSpace
//
//  Created by Donald Colin on 14/09/24.
//

import SwiftUI

struct RequestCellView: View {
    let request: Request
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // Profile image and username
                if let user = request.user{
                    CircularProfileImageView(user: user, size: .small)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    // Name and Location
                    Text(request.user?.username ?? "Unknown User")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(request.user?.fullname ?? "Unknown Location")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    // add pets detail (dog or cat , breed , gender)
                    // Tags (Dog owner, Dog walker, Vet)
                    HStack(spacing: 8) {
                        TagView(text: "Dog owner", color: .blue)
                        TagView(text: "Dog walker", color: .red)
                        TagView(text: "Vet", color: .green)
                    }
                    
                    // Caption
                    Text(request.caption)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .padding(.top, 4)
                    
                    // Date From and Date To
                    Text("Date from: \(request.datefrom, formatter: dateFormatter)")
                        .font(.caption)
                    Text("Date to: \(request.dateTo, formatter: dateFormatter)")
                        .font(.caption)
                    
                    // Time and Message Button
                    HStack {
//                        Text(request.timestamp, style: .relative)
//                            .font(.caption)
//                            .foregroundColor(.gray)
                        
                  
                        
                        Button(action: {
                            // Handle message action
                        }) {
                            Text("Message \(request.user?.fullname ?? "User")")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(25)
                        }
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
            }
            .padding()
            
            Divider()
        }
        .padding(.horizontal)
    }
}

struct TagView: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(20)
    }
}

#Preview {
    RequestCellView(request: Request.MOCK_Request[0])
}

// Date Formatter
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
