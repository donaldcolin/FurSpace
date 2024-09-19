//
//  TabbarView.swift
//  FurSpace
//
//  Created by Donald Colin on 13/09/24.
//

import SwiftUI
import MapKit

struct TabbarView: View {
    @State private var annotations: [MKPointAnnotation] = []
    
    var body: some View {
        TabView {
            CustomTabView()
                .tabItem {
                    Image(systemName: "house")
                  
                }
            
            // Provide the @State annotations and array of users to the Mapview
            LocationSearchView(users: User.MOCK_USER)
                .tabItem {
                    Image(systemName: "map")
                  
                }
            PostorRequestSelectionView()
                .tabItem {
                    Image(systemName: "plus")
                   
                }
            
            OwnServiceView()
                .tabItem {
                    Image(systemName: "cart.fill")
                   
                }
            
           
            
            UserProfileView(user: User.MOCK_USER[1])
                .tabItem {
                    Image(systemName: "person")
                    
                }
        }
    }
}

#Preview {
    TabbarView()
}
