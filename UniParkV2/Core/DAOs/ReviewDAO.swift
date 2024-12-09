//
//  ReviewDAO.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 7/12/24.
//

import Foundation
import FirebaseFirestore

class ReviewDAO: ReviewDAOProtocol {
    private var db = Firestore.firestore()
    
    // Crear una nueva reseña
    func createReview(_ review: Review) async throws {
        let encodedReview = try Firestore.Encoder().encode(review)
        try await db.collection("reviews").document(review.id).setData(encodedReview)
    }
    
    // Obtener una reseña por su ID
    func fetchReview(byId id: String) async throws -> Review? {
        let document = try await db.collection("reviews").document(id).getDocument()
        return try document.data(as: Review.self)
    }
    
    // Obtener todas las reseñas
    func fetchAllReviews() async throws -> [Review] {
        let snapshot = try await db.collection("reviews").getDocuments()
        return try snapshot.documents.compactMap { document in
            return try document.data(as: Review.self)
        }
    }
    
    // Actualizar una reseña existente
    func updateReview(_ review: Review) async throws {
        let encodedReview = try Firestore.Encoder().encode(review)
        try await db.collection("reviews").document(review.id).updateData(encodedReview)
    }
    
    // Eliminar una reseña por su ID
    func deleteReview(byId id: String) async throws {
        try await db.collection("reviews").document(id).delete()
    }
}
