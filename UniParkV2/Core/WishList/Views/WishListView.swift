//
//  WishListView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 24/10/24.
//

import SwiftUI

struct WishListView: View {
    @State private var showLogin = false
    
    @ObservedObject var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if authManager.userSessionId == nil {
                    WishlistLoginView(showLogin: $showLogin)
                } else {
                    WishlistEmptyStateView()
                }
            }
            .padding()
            .sheet(isPresented: $showLogin, content: {
                LoginView(authManager: authManager)
            })
            .navigationTitle("Wishlists")
        }
    }
}

#Preview {
    WishListView(authManager: AuthManager(service: MockAuthService()))
}
