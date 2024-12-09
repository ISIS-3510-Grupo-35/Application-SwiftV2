//
//  ReviewView.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import SwiftUI
import Combine

struct ReviewView: View {
    @State private var rating: Double = 2.5
    @State private var reviewText: String = ""
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @StateObject private var viewModel = ReviewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Review information")) {
                        Picker("Rating", selection: $rating) {
                            ForEach(Array(stride(from: 0.0, through: 5.0, by: 0.5)), id: \.self) { value in
                                Text(String(format: "%.1f", value))
                                    .tag(value)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section(header: Text("Details")) {
                        TextEditor(text: $reviewText)
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.horizontal, -5)
                            .multilineTextAlignment(.leading)
                            .onReceive(Just(reviewText)) { value in
                                let shortString = String(value.prefix(300))
                                if shortString != value {
                                    self.reviewText = shortString
                                }
                            }
                    }
                }
                
                Button(action: {
                    Task {
                        await submitReview()
                    }
                }) {
                    Text("Save Review")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 140, height: 40)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .navigationTitle("Write a review")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("¡Review saved!"), message: Text("Your review was successfully created."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func submitReview() async {
        // Verificar si hay conexión a Internet
        guard NetworkService.shared.isOnline else {
            // Mostrar alerta si no hay conexión
            alertMessage = "No internet connection. Please check your connection and try again."
            showAlert = true
            return
        }
        
        // Verificar que el texto de la reseña no esté vacío y la calificación sea válida
        guard !reviewText.isEmpty, rating > 0 else {
            alertMessage = "Please complete all fields."
            showAlert = true
            return
        }
        
        // Crear la reseña con el ViewModel
        await viewModel.createReview(calification: rating, reviewText: reviewText)
        
        // Mostrar alerta de éxito y limpiar los campos
        DispatchQueue.main.async {
            alertMessage = "Your review was successfully created."
            showAlert = true
            reviewText = "" // Limpiar el texto de la reseña
            rating = 3.0 // Restablecer la calificación
        }
    }
}

struct ParkingReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}

