//
//  AuthServiceProtocol.swift
//  UniParkV2
//
//  Created by Tomas Angel on 30/10/24.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String?
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> String?
    func signOut()
}
