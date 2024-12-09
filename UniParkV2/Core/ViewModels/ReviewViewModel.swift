//
//  ReviewViewModel.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var currentReview: Review?
    @Published var errorMessage: String?
    
    private let reviewDAO: ReviewDAOProtocol
    
    // Inicializador con inyección de dependencia
    init(reviewDAO: ReviewDAOProtocol = ReviewDAO()) {
        self.reviewDAO = reviewDAO
    }
    
    // Inicialización del ViewModel
    func initialize() async {
        await fetchAllReviews()
    }
    
    // Crear una nueva reseña
    func createReview(calification: Double, reviewText: String) async {
        let review = Review(id: UUID().uuidString, calification: calification, review: reviewText)
        do {
            try await reviewDAO.createReview(review)
            await fetchAllReviews()
        } catch {
            handleError(error, context: "Error creating review")
        }
    }
    
    // Obtener todas las reseñas
    func fetchAllReviews() async {
        do {
            reviews = try await reviewDAO.fetchAllReviews()
        } catch {
            handleError(error, context: "Error fetching reviews")
        }
    }
    
    // Eliminar una reseña
    func deleteReview(reviewId: String) async {
        do {
            try await reviewDAO.deleteReview(byId: reviewId)
            reviews.removeAll { $0.id == reviewId }
        } catch {
            handleError(error, context: "Error deleting review")
        }
    }
    
    // Actualizar una reseña
    func updateReview(review: Review) async {
        do {
            try await reviewDAO.updateReview(review)
            await fetchAllReviews()
        } catch {
            handleError(error, context: "Error updating review")
        }
    }
    
    // Manejar errores
    private func handleError(_ error: Error, context: String) {
        print("\(context): \(error.localizedDescription)")
        errorMessage = "\(context): \(error.localizedDescription)"
    }
    
}
