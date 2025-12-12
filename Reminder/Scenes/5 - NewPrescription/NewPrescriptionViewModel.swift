//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by NJ Development on 23/10/25.
//

import Foundation
import UserNotifications

final class NewPrescriptionViewModel {
    func addPrescription(medicine: String, time: String, recurrence: String, shouldTakeItNow: Bool) {
        DBHelper.shared.insertPrescription(medicine: medicine, time: time, recurrence: recurrence, shouldTakeItNow: shouldTakeItNow)
    }
    
    func addNotification(for prescription: Prescription) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Time to take your medication"
        content.body = "It's time to take your \(prescription.medicine)!"
        content.sound = .default
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let initialDate = formatter.date(from: prescription.time) else { return }
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: initialDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: prescription.id.description, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("Notification added successfully")
            }
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
