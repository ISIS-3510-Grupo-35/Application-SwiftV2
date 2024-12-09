//
//  ReservationViewModel.swift
//  UniParkV2
//
//  Created by Nicolás Hernández on 3/12/24.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservations: [Reservation] = []
    @Published var currentReservation: Reservation?
    @Published var errorMessage: String?

    private let reservationDAO: ReservationDAOProtocol

    init(reservationDAO: ReservationDAOProtocol = ReservationDAO()) {
        self.reservationDAO = reservationDAO
    }

    func initialize() async {
        await fetchAllReservations()
    }

    func createReservation(arrivalTime: String, departureTime: String, licensePlate: String, parkingId: Int, userId: Int) async {
        let reservation = Reservation(id: UUID().uuidString, arrivalTime: arrivalTime, departureTime: departureTime, licensePlate: licensePlate, parkingId: parkingId, userId: userId)
        do {
            try await reservationDAO.createReservation(reservation)
            await fetchAllReservations()
        } catch {
            handleError(error, context: "Error creating reservation")
        }
    }

    func fetchAllReservations() async {
        do {
            reservations = try await reservationDAO.fetchAllReservations()
        } catch {
            handleError(error, context: "Error fetching reservations")
        }
    }

    func deleteReservation(reservationId: String) async {
        do {
            try await reservationDAO.deleteReservation(reservationId)
            reservations.removeAll { $0.id == reservationId }
        } catch {
            handleError(error, context: "Error deleting reservation")
        }
    }
    
    func getFullCapacityTimes(parkingLotId: String, dayOfWeek: Int) async -> [Date]? {
        do {
            return try await reservationDAO.fetchFullCapacityTimes(parkingLotId, dayOfWeek: dayOfWeek)
        } catch {
            handleError(error, context: "Error fetching full capacity times")
            return nil
        }
    }

    func scheduleFullCapacityNotification(parkingLotId: String, dayOfWeek: Int) async {
        if let fullCapacityTimes = await getFullCapacityTimes(parkingLotId: parkingLotId, dayOfWeek: dayOfWeek) {
            if let latestFullCapacity = fullCapacityTimes.max(),
               let notificationTime = calculateNotificationTime(from: latestFullCapacity, offsetMinutes: -30) {
                print("Notification should be scheduled at \(notificationTime)")
            }
        }
    }

    private func calculateNotificationTime(from date: Date, offsetMinutes: Int) -> Date? {
        Calendar.current.date(byAdding: .minute, value: offsetMinutes, to: date)
    }

    private func handleError(_ error: Error, context: String) {
        errorMessage = "\(context): \(error.localizedDescription)"
    }
}
