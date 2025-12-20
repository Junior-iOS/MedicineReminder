//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by NJ Development on 23/10/25.
//

import Foundation
import UserNotifications

final class NewPrescriptionViewModel {
    private let notificationCenter: UNUserNotificationCenter

    init(notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }

    func addPrescription(prescription: Prescription, shouldTakeItNow: Bool) {
        var updatedTime = prescription.time
        
        if shouldTakeItNow {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            updatedTime = formatter.string(from: date)
        }
        
        if let insertedId = DBHelper.shared.insertPrescription(prescription: prescription, shouldTakeItNow: shouldTakeItNow) {
            let prescriptionWithId = Prescription(
                id: insertedId,
                medicine: prescription.medicine,
                time: updatedTime,
                recurrence: prescription.recurrence
            )
            addNotification(for: prescriptionWithId)
        }
    }

    func addNotification(for prescription: Prescription) {
        let content = UNMutableNotificationContent()
        content.title = "Time to take your medication"
        content.body = "It's time to take your \(prescription.medicine)!"
        content.sound = .default

        let recurrence = getIntervalRecurrence(from: prescription.recurrence)

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let initialDate = formatter.date(from: prescription.time) else { return }

        var currentDate = initialDate
        let calendar = Calendar.current

        for i in 0..<(24 / recurrence) {
            let dateComponents = calendar.dateComponents([.hour, .minute], from: initialDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "\(prescription.medicine) - \(i)", content: content, trigger: trigger)

            notificationCenter.add(request) { error in
                if let error {
                    print("Error adding notification: \(error)")
                } else {
                    print("Notification added successfully")
                }
            }

            currentDate = calendar.date(byAdding: .hour, value: recurrence, to: currentDate) ?? Date()
        }
    }

    private func getIntervalRecurrence(from options: RecurrenceOptions) -> Int {
        switch options {
        case .oneHour: 1
        case .twoHours: 2
        case .fourHours: 4
        case .sixHours: 6
        case .eightHours: 8
        case .twelveHours: 12
        case .onceADay: 24
        }
    }
}
