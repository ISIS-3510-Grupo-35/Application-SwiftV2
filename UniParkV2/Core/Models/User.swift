//
//  User.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import FirebaseAuth

struct User: Codable {
    // Propiedades de FirebaseAuth.User
    let uid: String
    let email: String?
    let displayName: String?
    let photoURL: URL?

    // Propiedades Personalizadas
    var balance: Double = 0.0
    var isDriver: Bool = false
    var favoriteParkingLots: [String]
    
    // Inicializador que recibe un objeto FirebaseAuth.User
    init(from firebaseUser: FirebaseAuth.User, balance: Double = 0.0, isDriver: Bool = false, favoriteParkingLots: [String] = []) {
        self.uid = firebaseUser.uid
        self.email = firebaseUser.email
        self.displayName = firebaseUser.displayName
        self.photoURL = firebaseUser.photoURL
        self.balance = balance
        self.isDriver = isDriver
        self.favoriteParkingLots = favoriteParkingLots
    }
}
