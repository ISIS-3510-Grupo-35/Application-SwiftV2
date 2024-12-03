//
//  ParkingLot.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

struct ParkingLot: Identifiable, Codable {
    var id: String?
    var address: String
    var capacity: Int
    var closingTime: Date
    var durationFullRate: Int
    var fullRate: Int
    var image: String
    var latitude: Double
    var longitude: Double
    var name: String
    var openingTime: Date
    var priceMinute: Int
    var review: Double
    var userID: Int
}
