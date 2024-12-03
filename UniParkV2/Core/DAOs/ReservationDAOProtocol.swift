//
//  ReservationDAOProtocol.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

protocol ReservationDAOProtocol {
    func createReservation(_ reservation: Reservation) async throws
    func fetchAllReservations() async throws -> [Reservation]
    func deleteReservation(_ reservationId: String) async throws
    func fetchFullCapacityTimes(_ parkingLotId: String, dayOfWeek: Int) async throws -> [Date]
}
