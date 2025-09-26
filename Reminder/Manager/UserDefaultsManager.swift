//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private enum Keys {
        static let user = "userKey"
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
}
