//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private enum Keys {
        static let user = "userKey"
        static let userName = "userName"
        static let profileImage = "profileImage"
    }
    
    func save(_ user: User) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            defaults.set(data, forKey: Keys.user)
        } catch {
            print("UserDefaultsManager.save error:", error)
        }
    }
    
    func loadUser() -> User? {
        guard let data = defaults.data(forKey: Keys.user) else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            print("UserDefaultsManager.loadUser decode error:", error)
            return nil
        }
    }
    
    func removeUser() {
        defaults.removeObject(forKey: Keys.user)
        defaults.removeObject(forKey: Keys.userName)
        defaults.removeObject(forKey: Keys.profileImage)
    }
    
    func saveUserName(_ name: String) {
        defaults.set(name, forKey: Keys.userName)
    }
    
    func loadUserName() -> String? {
        return defaults.string(forKey: Keys.userName)
    }
    
    func saveProfileImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            defaults.set(imageData, forKey: Keys.profileImage)
        }
    }
    
    func loadProfileImage() -> UIImage? {
        guard let imageData = defaults.data(forKey: Keys.profileImage) else {
            return UIImage(icon: .personCropCircleFill)
        }
        return UIImage(data: imageData)
    }
}
