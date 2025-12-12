//
//  PrescriptionsViewModel.swift
//  Reminder
//
//  Created by NJ Development on 09/12/25.
//

import Foundation

final class PrescriptionsViewModel {
    var prescriptions: [Prescription] = []
    
    func fetchData() {
        prescriptions = DBHelper.shared.fetchPrescriptions()
    }
    
    func deletePrescription(by id: Int) {
        DBHelper.shared.deletePrescription(by: id)
    }
}
