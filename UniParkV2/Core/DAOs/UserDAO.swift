//
//  UserDAO.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import FirebaseFirestore

class UserDAO: UserDAOProtocol {
    private var db = FirestoreService.shared.getFirestoreReference()

    // Crear un nuevo usuario
    func createUser(_ user: User) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        try await db.collection("users").document(user.uid).setData(encodedUser)
    }

    // Obtener un usuario por su ID
    func fetchUser(byId id: String) async throws -> User? {
        let document = try await db.collection("users").document(id).getDocument()
        return try document.data(as: User.self)
    }

    // Obtener todos los usuarios
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await db.collection("users").getDocuments()
        return try snapshot.documents.compactMap { document in
            return try document.data(as: User.self)
        }
    }

    // Actualizar un usuario
    func updateUser(_ user: User) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        try await db.collection("users").document(user.uid).updateData(encodedUser)
    }

    // Eliminar un usuario por su ID
    func deleteUser(byId id: String) async throws {
        try await db.collection("users").document(id).delete()
    }
}
