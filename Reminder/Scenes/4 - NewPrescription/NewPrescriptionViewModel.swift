//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by NJ Development on 23/10/25.
//

import Foundation

final class NewPrescriptionViewModel {
    func addPrescription(medicine: String, time: String, recurrence: String, shouldTakeItNow: Bool) {
        DBHelper.shared.insertPrescription(medicine: medicine, time: time, recurrence: recurrence, shouldTakeItNow: shouldTakeItNow)
    }
}
