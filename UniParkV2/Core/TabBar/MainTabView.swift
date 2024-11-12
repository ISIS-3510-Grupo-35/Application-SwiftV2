//
//  MainTabView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 24/10/24.
//

import SwiftUI

struct MainTabView: View {
    
    private let authManager: AuthManager
    
    init (authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            
            WishListView(authManager: authManager)
                .tabItem { Label("Wishlists", systemImage: "heart") }
            
            ProfileView(authManager: authManager)
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}

#Preview {
    MainTabView(authManager: AuthManager(service: MockAuthService()))
}
