//
//  MockAuthService.swift
//  UniParkV2
//
//  Created by Tomas Angel on 29/10/24.
//

import Foundation

struct MockAuthService: AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String? {
        return NSUUID().uuidString
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> String? {
        return NSUUID().uuidString
    }
    
    func signOut() {
        
    }
}
