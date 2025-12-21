//
//  SplashViewModel.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation

enum SplashNavigationFlow {
    case login
    case home
    case faceID
}

protocol SplashViewModelProtocol {
    func checkNavigationFlow() -> SplashNavigationFlow
    func shouldAuthenticateWithFaceID() -> Bool
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
}
