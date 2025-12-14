//
//  AppDelegate.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Firebase
import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        registerNotifications()
        return true
    }

    // MARK: - Notifications
    private func registerNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }
}
