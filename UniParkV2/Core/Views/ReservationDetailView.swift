//
//  ReservationDetailView.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 8/12/24.
//

import SwiftUI

struct ReservationDetailView: View {
    let reserva: Reservation

    var body: some View {
        VStack(spacing: 20) {
            Text("Detalle de la Reserva")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 15) {
                Text("ID: \(reserva.id)")
                Text("Hora de llegada: \(reserva.arrivalTime)")
                Text("Hora de salida: \(reserva.departureTime)")
                Text("Matrícula: \(reserva.licensePlate)")
                Text("ID de Estacionamiento: \(reserva.parkingId)")
                Text("ID de Usuario: \(reserva.userId)")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(10)

            HStack(spacing: 20) {
                Button(action: editarReserva) {
                    Text("Editar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Button(action: cancelarReserva) {
                    Text("Cancelar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
    
    // Acciones simuladas
    func editarReserva() {
        print("Editar reserva: \(reserva.id)")
    }

    func cancelarReserva() {
        print("Cancelar reserva: \(reserva.id)")
    }
}

struct ReservaDetalleView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationDetailView(reserva: Reservation(
            id: "123ABC",
            arrivalTime: "10:00 AM",
            departureTime: "12:00 PM",
            licensePlate: "XYZ-1234",
            parkingId: 101,
            userId: 1
        ))
    }
}

