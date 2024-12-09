//
//  ParkingLot.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation
import CoreLocation

struct ParkingLot: Identifiable, Codable, Hashable {
    var id: String?
    var address: String
    var capacity: Int
    var closingTime: Date
    var durationFullRate: Int
    var fullRate: Int
    var image: String
    var latitude: Double
    var longitude: Double
    var coordinates: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
    var name: String
    var openingTime: Date
    var priceMinute: Int
    var review: Double
    var userID: Int
}
