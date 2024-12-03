//
//  ParkingLotDAO.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import FirebaseFirestore

class ParkingLotDAO: ParkingLotDAOProtocol {
    private var db = FirestoreService.shared.getFirestoreReference()

    func createParkingLot(_ parkingLot: ParkingLot) async throws {
        guard let id = parkingLot.id else {
            throw NSError(domain: "ParkingLotDAO", code: 0, userInfo: [NSLocalizedDescriptionKey: "ParkingLot ID is nil"])
        }
        let encodedParkingLot = try Firestore.Encoder().encode(parkingLot)
        try await db.collection("parkingLots").document(id).setData(encodedParkingLot)
    }

    func fetchAllParkingLots() async throws -> [ParkingLot] {
        let snapshot = try await db.collection("parkingLots").getDocuments()
        return try snapshot.documents.compactMap { document in
            return try document.data(as: ParkingLot.self)
        }
    }

    func deleteParkingLot(_ parkingLotId: String) async throws {
        try await db.collection("parkingLots").document(parkingLotId).delete()
    }

    func updateParkingLot(_ parkingLot: ParkingLot) async throws {
        guard let id = parkingLot.id else {
            throw NSError(domain: "ParkingLotDAO", code: 0, userInfo: [NSLocalizedDescriptionKey: "ParkingLot ID is nil"])
        }
        let encodedParkingLot = try Firestore.Encoder().encode(parkingLot)
        try await db.collection("parkingLots").document(id).updateData(encodedParkingLot)
    }

    func fetchParkingLot(byId id: String) async throws -> ParkingLot? {
        let document = try await db.collection("parkingLots").document(id).getDocument()
        return try document.data(as: ParkingLot.self)
    }
}

