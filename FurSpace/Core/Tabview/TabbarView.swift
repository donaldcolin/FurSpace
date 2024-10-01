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
    let user : User
    var body: some View {
        TabView {
            CustomTabView()
                .tabItem {
                    Image(systemName: "house")
                  
                }
            // Provide the @State annotations and array of users to the Mapview
            SwiftUiMap()
                .tabItem {
                    Image(systemName: "map")
                  
                }
            PostorRequestSelectionView()
                .tabItem {
                    Image(systemName: "plus")
                   
                }
            
          SearchView()
                .tabItem {
                    Image(systemName: "cart.fill")
                   
                }
            
           
            
            UserProfileView(user: user)
                .tabItem {
                    Image(systemName: "person")
                    
                }
        }
    }
}

#Preview {
    TabbarView(user: User.MOCK_USER[1])
}
