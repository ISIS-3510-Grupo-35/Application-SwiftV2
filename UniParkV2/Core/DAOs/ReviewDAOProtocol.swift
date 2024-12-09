//
//  ReviewDAOProtocol.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 7/12/24.
//

import Foundation

protocol ReviewDAOProtocol {
    func createReview(_ review: Review) async throws
    func fetchReview(byId id: String) async throws -> Review?
    func fetchAllReviews() async throws -> [Review]
    func updateReview(_ review: Review) async throws
    func deleteReview(byId id: String) async throws
}
