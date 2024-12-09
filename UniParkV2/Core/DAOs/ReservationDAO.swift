//
//  ReservationDAO.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import FirebaseFirestore

class ReservationDAO: ReservationDAOProtocol {
    
    private var db = FirestoreService.shared.getFirestoreReference()
    
    func createReservation(_ reservation: Reservation) async throws {
        let encodedReservation = try Firestore.Encoder().encode(reservation)
        try await db.collection("reservations").document(reservation.id).setData(encodedReservation)
    }
    
    func fetchAllReservations() async throws -> [Reservation] {
        let snapshot = try await db.collection("reservations").getDocuments()
        return try snapshot.documents.compactMap { document in
            return try document.data(as: Reservation.self)
        }
    }
    
    func deleteReservation(_ reservationId: String) async throws {
        try await db.collection("reservations").document(reservationId).delete()
    }
    
    func fetchFullCapacityTimes(_ parkingLotId: String, dayOfWeek: Int) async throws -> [Date] {
        let snapshot = try await db.collection("parkingLots")
            .document(parkingLotId)
            .collection("availabilityHistory")
            .whereField("availableSpots", isEqualTo: 0)
            .whereField("dayOfWeek", isEqualTo: dayOfWeek)
            .getDocuments()
        
        return snapshot.documents.compactMap { $0["timestamp"] as? Date }
    }

}
