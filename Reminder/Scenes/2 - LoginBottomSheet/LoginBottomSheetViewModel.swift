//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import FirebaseAuth
import Foundation
import LocalAuthentication

enum FaceIDEnableResult {
    case success
    case failure
    case notAvailable
}

protocol LoginbottomSheetViewModelProtocol {
    func authenticate(user: String, password: String)
    func saveUser(email: String, isUserLoggedIn: Bool, hasFaceID: Bool)
    func checkFaceIDAvailability() -> Bool
    func enableFaceID(with email: String, completion: @escaping (FaceIDEnableResult) -> Void)
    var successResult: ((String) -> Void)? { get set }
    var errorResult: ((String) -> Void)? { get set }
}

final class LoginBottomSheetViewModel: LoginbottomSheetViewModelProtocol {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    private let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager = .shared) {
        self.userDefaultsManager = userDefaultsManager
    }

    func authenticate(user: String, password: String) {
        if isValidEmail(user) {
            print("Attempting sign in for user: \(user)")
            Auth.auth().signIn(withEmail: user, password: password) { (_: AuthDataResult?, error: Error?) in
                if let error = error as NSError? {
                    let authCode = AuthErrorCode(_bridgedNSError: error)
                    let message: String
                    switch authCode?.code {
                    case .invalidEmail:
                        message = NSLocalizedString("auth.invalid_email", comment: "Invalid email")

                    case .userDisabled:
                        message = NSLocalizedString("auth.user_disabled", comment: "User disabled")

                    case .userNotFound:
                        message = NSLocalizedString("auth.user_not_found", comment: "User not found")

                    case .wrongPassword:
                        message = NSLocalizedString("auth.wrong_password", comment: "Wrong password")

                    case .invalidCredential:
                        message = NSLocalizedString("auth.invalid_credential", comment: "Invalid credential")

                    case .operationNotAllowed:
                        message = NSLocalizedString("auth.operation_not_allowed", comment: "Operation not allowed")

                    case .networkError:
                        message = NSLocalizedString("auth.network_error", comment: "Network error")

                    default:
                        message = error.localizedDescription
                    }
                    print("Authentication failed (code: \(error.code)): \(message) | info: \(error.userInfo)")
                    self.errorResult?(message)
                } else {
                    print("User authenticated successfully: \(user)")
                    self.successResult?(user)
                }
            }
        } else {
            print(NSLocalizedString("auth.invalid_email", comment: "Invalid email"))
        }
    }
    
    func saveUser(email: String, isUserLoggedIn: Bool, hasFaceID: Bool) {
        let user = User(email: email, isUserLoggedIn: isUserLoggedIn, hasFaceID: hasFaceID)
        userDefaultsManager.save(user)
    }
    
    func checkFaceIDAvailability() -> Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    func enableFaceID(with email: String, completion: @escaping (FaceIDEnableResult) -> Void) {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            DispatchQueue.main.async {
                completion(.notAvailable)
            }
            return
        }

        let reason = "Log in to your account, \(email)"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            DispatchQueue.main.async {
                completion(success ? .success : .failure)
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
