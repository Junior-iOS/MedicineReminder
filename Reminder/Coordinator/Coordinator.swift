//
//  Coordinator.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation
import UIKit

final class Coordinator {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactory
    
    // MARK: - Init
    init() {
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    func start() -> UINavigationController {
        let splashVC = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        navigationController = UINavigationController(rootViewController: splashVC)
        return navigationController ?? UINavigationController()
    }
}

// MARK: - LOGIN
extension Coordinator: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: true)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBlue
        navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - SPLASH
extension Coordinator: SplashFlowDelegate {
    func navigateToLogin() {
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateBottomSheet()
        }
    }
}
