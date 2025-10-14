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
}

final class HomeViewModel: HomeViewModelProtocol {
    var userName: String? {
        if let username = UserDefaultsManager.shared.loadUserName() {
            return username
        } else {
            return nil
        }
    }
}
