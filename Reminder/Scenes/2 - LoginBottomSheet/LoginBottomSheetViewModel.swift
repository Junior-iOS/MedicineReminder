//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation
import FirebaseAuth

protocol LoginbottomSheetViewModelProtocol {
    func authenticate(user: String, password: String)
    var successResult: ((String) -> Void)? { get set }
}

final class LoginBottomSheetViewModel: LoginbottomSheetViewModelProtocol {
    
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func authenticate(user: String, password: String) {
        if isValidEmail(user) {
            print("User: \(user) - Password: \(password)")
            Auth.auth().signIn(withEmail: user, password: password) { (authResult: AuthDataResult?, error: Error?) in
                if let error = error {
                    print("Authentication failed: \(error.localizedDescription)")
                    self.errorResult?(error.localizedDescription)
                } else {
                    self.successResult?(user)
                    print("User authenticated successfully")
                }
            }
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
