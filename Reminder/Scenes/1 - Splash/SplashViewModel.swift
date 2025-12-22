//
//  SplashViewModel.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation
import LocalAuthentication

enum SplashNavigationFlow {
    case login
    case home
    case faceID
}

enum FaceIDAuthenticationResult {
    case success
    case failure
    case notAvailable
}

protocol SplashViewModelProtocol {
    func checkNavigationFlow() -> SplashNavigationFlow
    func shouldAuthenticateWithFaceID() -> Bool
    func authenticateWithFaceID(completion: @escaping (FaceIDAuthenticationResult) -> Void)
}

final class SplashViewModel: SplashViewModelProtocol {
    private let userDefaultsManager: UserDefaultsManager

    init(userDefaultsManager: UserDefaultsManager = .shared) {
        self.userDefaultsManager = userDefaultsManager
    }

    func checkNavigationFlow() -> SplashNavigationFlow {
        guard let user = userDefaultsManager.loadUser(), user.isUserLoggedIn else {
            return .login
        }

        if user.hasFaceID {
            return .faceID
        }

        return .home
    }

    func shouldAuthenticateWithFaceID() -> Bool {
        guard let user = userDefaultsManager.loadUser() else { return false }
        return user.isUserLoggedIn && user.hasFaceID
    }
    
    func authenticateWithFaceID(completion: @escaping (FaceIDAuthenticationResult) -> Void) {
        let context = LAContext()
        var authError: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) else {
            completion(.notAvailable)
            return
        }

        let reason = "Authenticate to access your account"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
            DispatchQueue.main.async {
                completion(success ? .success : .failure)
            }
        }
    }
}
