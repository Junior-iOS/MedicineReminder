//
//  String+Extensions.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
