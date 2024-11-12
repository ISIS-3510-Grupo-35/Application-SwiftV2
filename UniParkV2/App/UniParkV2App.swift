//
//  UniParkV2App.swift
//  UniParkV2
//
//  Created by Tomas Angel on 22/10/24.
//

import SwiftUI

@main
struct UniParkV2App: App {
    let authManager = AuthManager(service: MockAuthService())
    
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
        }
    }
}
