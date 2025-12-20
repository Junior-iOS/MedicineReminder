//
//  PrescriptionsViewModel.swift
//  Reminder
//
//  Created by NJ Development on 09/12/25.
//

import Foundation
import UserNotifications

protocol PrescriptionsViewModelProtocol: AnyObject {
    var prescriptions: [Prescription] { get }
    var onDataChanged: (() -> Void)? { get set }
    func fetchData()
    func deletePrescription(by id: Int)
    func deletePrescription(at index: Int)
    func updatePrescription(by prescription: Prescription)
}

final class PrescriptionsViewModel: PrescriptionsViewModelProtocol {
    private let notificationCenter: UNUserNotificationCenter
    private(set) var prescriptions: [Prescription] = []
    var onDataChanged: (() -> Void)?

    init(notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }

    func fetchData() {
        prescriptions = DBHelper.shared.fetchPrescriptions()
        onDataChanged?()
    }

    func deletePrescription(by id: Int) {
        DBHelper.shared.deletePrescription(by: id)
        prescriptions.removeAll { $0.id == id }
        onDataChanged?()
    }
    
    func deletePrescription(at index: Int) {
        guard index >= 0 && index < prescriptions.count else { return }
        let prescription = prescriptions[index]
        if let id = prescription.id {
            DBHelper.shared.deletePrescription(by: id)
            removeNotifications(for: prescription)
            prescriptions.remove(at: index)
            onDataChanged?()
        }
    }

    func updatePrescription(by prescription: Prescription) {
        DBHelper.shared.updatePrescription(prescription, shouldTakeItNow: false)
        if let index = prescriptions.firstIndex(where: { $0.id == prescription.id }) {
            prescriptions[index] = prescription
            onDataChanged?()
        }
    }

    private func removeNotifications(for prescription: Prescription) {
        let identifiers = (0..<6).map { "\(prescription.medicine) - \($0)" }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
