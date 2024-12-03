//
//  ParkingLotViewModel.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestore

class ParkingLotViewModel: ObservableObject {
    private let cacheService = CacheService.shared
    var parkingLots: [ParkingLot] = []
    var selectedParkingLot: ParkingLot?
    var errorMessage: String?

    private let parkingLotDAO: ParkingLotDAOProtocol

    init(parkingLotDAO: ParkingLotDAOProtocol = ParkingLotDAO()) {
        self.parkingLotDAO = parkingLotDAO
    }

    // Method to initialize and load all parking lots
    func initialize() async {
        await fetchAllParkingLots()
    }

    // Fetch all parking lots
    func fetchAllParkingLots() async {
        if let cachedParkingLots = CacheService.shared.getParkingLotsCache() {
            print("Parking lots loaded from cache")
            parkingLots = cachedParkingLots.sorted { $0.name < $1.name } // Sort alphabetically by name
        } else {
            do {
                if NetworkService.shared.isOnline {
                    print("Fetching parking lots from Firebase...")
                    parkingLots = try await parkingLotDAO.fetchAllParkingLots()
                    if !parkingLots.isEmpty {
                        CacheService.shared.setParkingLotsCache(parkingLots)
                    }
                    parkingLots = parkingLots.sorted { $0.name < $1.name } // Sort alphabetically by name
                } else {
                    print("No cache available and network is offline...")
                    errorMessage = "No internet connection and no cached data available."
                }
            } catch {
                print("[Parking Lots] Fetching error: \(error)")
                errorMessage = "Error fetching parking lots: \(error.localizedDescription)"
            }
        }
    }


    // Create a new parking lot
    func createParkingLot(
        address: String,
        capacity: Int,
        closingTime: Date,
        durationFullRate: Int,
        fullRate: Int,
        image: String,
        latitude: Double,
        longitude: Double,
        name: String,
        openingTime: Date,
        priceMinute: Int,
        review: Double,
        userID: Int
    ) async {
        let newParkingLot = ParkingLot(
            id: UUID().uuidString,
            address: address,
            capacity: capacity,
            closingTime: closingTime,
            durationFullRate: durationFullRate,
            fullRate: fullRate,
            image: image,
            latitude: latitude,
            longitude: longitude,
            name: name,
            openingTime: openingTime,
            priceMinute: priceMinute,
            review: review,
            userID: userID
        )

        do {
            try await parkingLotDAO.createParkingLot(newParkingLot)
            await fetchAllParkingLots() // Refresh parking lots
        } catch {
            handleError(error, context: "Error creating parking lot")
        }
    }

    // Update an existing parking lot
    func updateParkingLot(_ parkingLot: ParkingLot) async {
        do {
            try await parkingLotDAO.updateParkingLot(parkingLot)
            await fetchAllParkingLots() // Refresh parking lots
        } catch {
            handleError(error, context: "Error updating parking lot")
        }
    }

    // Delete a parking lot
    func deleteParkingLot(byId id: String) async {
        do {
            try await parkingLotDAO.deleteParkingLot(id)
            parkingLots.removeAll { $0.id == id } // Remove locally
        } catch {
            handleError(error, context: "Error deleting parking lot")
        }
    }

    // Handle errors and update error message
    private func handleError(_ error: Error, context: String) {
        errorMessage = "\(context): \(error.localizedDescription)"
    }
}

