//
//  Medicine.swift
//  Reminder
//
//  Created by NJ Development on 09/12/25.
//

import Foundation

struct Prescription {
    let id: Int?
    let medicine: String
    let time: String
    let recurrence: RecurrenceOptions

    init(id: Int? = nil, medicine: String, time: String, recurrence: RecurrenceOptions) {
        self.id = id
        self.medicine = medicine
        self.time = time
        self.recurrence = recurrence
    }
}
