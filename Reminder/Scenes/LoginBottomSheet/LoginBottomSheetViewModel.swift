//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation

final class LoginBottomSheetViewModel {
    
    func authenticate(user: String, password: String) {
        if isValidEmail(user) {
            print("User: \(user) - Password: \(password)")
        } else {
            print("Invalid email")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
