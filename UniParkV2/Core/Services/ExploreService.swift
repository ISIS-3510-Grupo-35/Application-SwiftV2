//
//  ExploreService.swift
//  UniParkV2
//
//  Created by Tomas Angel on 27/10/24.
//

import Foundation

class ExploreService {
    func fetchListings() async throws -> [Listing] {
        return DeveloperPreview.shared.listings
    }
}
