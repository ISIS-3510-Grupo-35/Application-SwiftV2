//
//  CacheService.swift
//  UniParkV2
//
//  Created by Ingrith Barbosa on 3/12/24.
//

import Foundation

@Observable
class CacheService {
    static let shared = CacheService()
    
    private let parkingLotsCache = NSCache<NSString, NSArray>()
    private let reservationsCache = NSCache<NSString, NSArray>()
    private let usersCache = NSCache<NSString, NSArray>()
    
    private init() {}
    
    func setParkingLots(_ parkingLots: [ParkingLot]) {
        if !parkingLots.isEmpty {
            let nsArray = parkingLots as NSArray
            parkingLotsCache.setObject(nsArray, forKey: "ParkingLots")
            print("PARKINGLOTS have been set to: \(parkingLots.count)")
        }
    }
    
    func getParkingLots() -> [ParkingLot]? {
        return parkingLotsCache.object(forKey: "ParkingLots") as? [ParkingLot]
    }
    
    func setReservations(_ reservations: [Reservation]) {
        if !reservations.isEmpty {
            let nsArray = reservations as NSArray
            reservationsCache.setObject(nsArray, forKey: "Reservations")
            print("RESERVATIONS have been set to: \(reservations.count)")
        }
    }
    
    func getReservations() -> [Reservation]? {
        return reservationsCache.object(forKey: "reservations") as? [Reservation]
    }
    
    func getParkingLotsCache() -> [ParkingLot]? {
        return parkingLotsCache.object(forKey: "parkingLots" as NSString) as? [ParkingLot]
    }

    func setParkingLotsCache(_ parkingLots: [ParkingLot]) {
        parkingLotsCache.setObject(parkingLots as NSArray, forKey: "parkingLots" as NSString)
    }
    
    func setUsersCache(_ users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: "usersCache")
        } catch {
            print("Error encoding users for cache: \(error)")
        }
    }
    
    func getUsersCache() -> [User]? {
        guard let data = UserDefaults.standard.data(forKey: "usersCache") else { return nil }
        do {
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("Error decoding users from cache: \(error)")
            return nil
        }
    }
    func clearUsersCache() {
        UserDefaults.standard.removeObject(forKey: "usersCache")
    }
}
