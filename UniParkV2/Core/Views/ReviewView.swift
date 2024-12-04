//
//  ReviewView.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import SwiftUI

struct ParkingReviewView: View {
    @State private var title: String = ""
    @State private var rating: Int = 3
    @State private var reviewText: String = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Información de la Reseña")) {
                        TextField("Título", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Picker("Calificación", selection: $rating) {
                            ForEach(1...5, id: \.self) { stars in
                                HStack {
                                    ForEach(0..<stars, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .tag(stars)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section(header: Text("Detalles")) {
                        TextEditor(text: $reviewText)
                            .frame(height: 150)
                            .border(Color.gray.opacity(0.5), width: 1)
                            .cornerRadius(8)
                            .padding(.horizontal, -5)
                    }
                }
                
                Button(action: submitReview) {
                    Text("Guardar Reseña")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(title.isEmpty || reviewText.isEmpty)
            }
            .navigationTitle("Crear Reseña")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("¡Reseña Guardada!"), message: Text("Tu reseña ha sido registrada exitosamente."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func submitReview() {
        // Lógica para guardar reseña (simulación)
        showAlert = true
        title = ""
        rating = 3
        reviewText = ""
    }
}

struct ParkingReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingReviewView()
    }
}

