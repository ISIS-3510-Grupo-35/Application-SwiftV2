//
//  Review.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 7/12/24.
//

import Foundation

struct Review: Identifiable, Codable {
    let id: String
    let calification: Double
    let review: String
    
}
