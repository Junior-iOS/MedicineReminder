//
//  PrescriptionsViewModel.swift
//  Reminder
//
//  Created by NJ Development on 09/12/25.
//

import Foundation
import UserNotifications

final class PrescriptionsViewModel {
    private let notificationCenter: UNUserNotificationCenter
    var prescriptions: [Prescription] = []
    
    init(notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }
    
    func fetchData() {
        prescriptions = DBHelper.shared.fetchPrescriptions()
    }
    
    func deletePrescription(by id: Int) {
        DBHelper.shared.deletePrescription(by: id)
    }
    
    func updatePrescription(by prescription: Prescription) {
        DBHelper.shared.updatePrescription(prescription, shouldTakeItNow: false)
    }
    
    private func removeNotifications(for prescription: Prescription) {
        let identifiers = (0..<6).map { "\(prescription.medicine) - \($0)" }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(prescription.medicine)"])
    }
}
