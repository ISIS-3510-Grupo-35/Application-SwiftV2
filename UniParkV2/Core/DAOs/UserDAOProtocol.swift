//
//  UserDAOProtocol.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

protocol UserDAOProtocol {
    func createUser(_ user: User) async throws
    func fetchUser(byId id: String) async throws -> User?
    func fetchAllUsers() async throws -> [User]
    func updateUser(_ user: User) async throws
    func deleteUser(byId id: String) async throws
}
