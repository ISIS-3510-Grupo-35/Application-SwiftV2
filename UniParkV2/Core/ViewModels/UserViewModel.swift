//
//  UserViewModel.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//
import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    private let cacheService = CacheService.shared
    var users: [User] = []
    var selectedUser: User?
    var errorMessage: String?

    private let userDAO: UserDAOProtocol

    init(userDAO: UserDAOProtocol = UserDAO()) {
        self.userDAO = userDAO
    }

    func initialize() async {
        await fetchAllUsers()
    }

    func fetchAllUsers() async {
        if let cachedUsers = cacheService.getUsersCache() {
            print("Users loaded from local cache")
            users = cachedUsers.sorted { $0.displayName! < $1.displayName! }
        } else {
            do {
                if NetworkService.shared.isOnline {
                    print("Fetching users from Firebase...")
                    users = try await userDAO.fetchAllUsers()
                    if !users.isEmpty {
                        cacheService.setUsersCache(users) // Guardar en caché local
                    }
                    users = users.sorted { $0.displayName! < $1.displayName! }
                } else {
                    print("No cache available and network is offline...")
                    errorMessage = "No internet connection and no cached data available."
                }
            } catch {
                print("[Users] Fetching error: \(error)")
                errorMessage = "Error fetching users: \(error.localizedDescription)"
            }
        }
    }

    func createUser(
        fullname: String,
        email: String,
        password: String,
        isDriver: Bool,
        balance: Double,
        favoriteParkingLots: [String]
    ) async {
        guard let firebaseUser = Auth.auth().currentUser else {
            print("Error: No authenticated user found.")
            return
        }
        let newUser = User(
                from: firebaseUser,
                balance: balance,
                isDriver: isDriver,
                favoriteParkingLots: favoriteParkingLots
            )

        do {
            try await userDAO.createUser(newUser)
            users.append(newUser)
            cacheService.setUsersCache(users) // Actualizar caché local
        } catch {
            handleError(error, context: "Error creating user")
        }
    }

    func updateUser(_ user: User) async {
        do {
            try await userDAO.updateUser(user)
            if let index = users.firstIndex(where: { $0.uid == user.uid }) {
                users[index] = user
                cacheService.setUsersCache(users) // Actualizar caché local
            }
        } catch {
            handleError(error, context: "Error updating user")
        }
    }

    func deleteUser(byId id: String) async {
        do {
            try await userDAO.deleteUser(byId: id)
            users.removeAll { $0.uid == id }
            cacheService.setUsersCache(users) // Actualizar caché local
        } catch {
            handleError(error, context: "Error deleting user")
        }
    }

    private func handleError(_ error: Error, context: String) {
        errorMessage = "\(context): \(error.localizedDescription)"
    }
}


