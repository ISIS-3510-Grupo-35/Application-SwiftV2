//
//  ParkingLotDAOProtocol.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

protocol ParkingLotDAOProtocol {
    func createParkingLot(_ parkingLot: ParkingLot) async throws
    func fetchAllParkingLots() async throws -> [ParkingLot]
    func deleteParkingLot(_ parkingLotId: String) async throws
    func updateParkingLot(_ parkingLot: ParkingLot) async throws
    func fetchParkingLot(byId id: String) async throws -> ParkingLot?
}
