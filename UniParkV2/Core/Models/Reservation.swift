//
//  Reservation.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

struct Reservation: Identifiable, Codable {
    let id: String
    let arrivalTime: String
    let departureTime: String
    let licensePlate: String
    let parkingId: Int
    let userId: Int
}
