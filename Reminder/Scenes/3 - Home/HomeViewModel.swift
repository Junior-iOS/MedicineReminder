//
//  HomeViewModel.swift
//  Reminder
//
//  Created by NJ Development on 13/10/25.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var userName: String? { get }
    var profileImage: UIImage? { get }
    func loadUserData() -> (userName: String?, profileImage: UIImage?)
    func saveProfileImage(_ image: UIImage)
    func removeUser()
}

final class HomeViewModel: HomeViewModelProtocol {
    private let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager = .shared) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    var userName: String? {
        userDefaultsManager.loadUserName()
    }
    
    var profileImage: UIImage? {
        userDefaultsManager.loadProfileImage()
    }
    
    func loadUserData() -> (userName: String?, profileImage: UIImage?) {
        let userName = userDefaultsManager.loadUserName()
        let profileImage = userDefaultsManager.loadProfileImage()
        return (userName, profileImage)
    }
    
    func saveProfileImage(_ image: UIImage) {
        userDefaultsManager.saveProfileImage(image)
    }
    
    func removeUser() {
        userDefaultsManager.removeUser()
    }
}
