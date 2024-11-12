//
//  ContentView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var body: some View {
        MainTabView(authManager: authManager)
    }
}

#Preview {
    ContentView(authManager: AuthManager(service: MockAuthService()))
}
