//
//  Listing.swift
//  UniParkV2
//
//  Created by Tomas Angel on 24/10/24.
//

import Foundation
import CoreLocation

struct Listing: Identifiable, Codable, Hashable {
    let id: String
    
    // owner
    let ownerUid: String
    let ownerName: String
    let ownerImageUrl: String
    
    // spots
    let numberOfSpots: Int
    
    // pricing
    var pricePlain: Int
    var pricePerMinute: Int
    
    // location
    let latitude: Double
    let longitude: Double
    let address: String
    let city: String
    let university: String
    let title: String
    
    // rating
    var rating: Double
    
    // lists
    var imageURLs: [String]
    var features: [ListingFeatures]
    var amenities: [ListingAmenities]
    let type: ListingType
    
    // coordinates
    var coordinates: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
}

enum ListingFeatures: Int, Codable, Identifiable, Hashable {
    case selfCheckIn
    case superHost
    
    var imageName: String {
        switch self {
            case .selfCheckIn: return "door.left.hand.open"
            case .superHost: return "medal"
        }
    }
    
    var title: String {
        switch self {
            case .selfCheckIn: return "Self check-in"
            case .superHost: return "Superhost"
        }
    }
    
    var subtitles: String {
        switch self {
            case .selfCheckIn: return "Check yourself in with the keypad"
            case .superHost: return "Superhosts are expirienced, highly rated hosts who are commited to providing great expiriences to guests."
        }
    }
    
    var id: Int {return self.rawValue}
}

enum ListingAmenities: Int, Codable, Identifiable, Hashable {
    case tv
    case llaves
    case sinLlaves
    
    var title: String {
        switch self {
        case .tv: return "tv"
        case .llaves: return "car"
        case .sinLlaves: return "car"
        }
    }
    
    var id: Int {return self.rawValue}
}

enum ListingType: Int, Codable, Identifiable, Hashable {
    case apartment
    case house
    
    var description: String {
        switch self {
        case .apartment: return "Apartment"
        case .house: return "House"
        }
    }
    
    var id: Int {return self.rawValue}
}
