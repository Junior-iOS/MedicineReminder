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
        let viewController = HomeViewController(view: HomeView(), delegate: self)
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

extension Coordinator: HomeFlowDelegate {
    func logout() {
        self.navigationController?.popToRootViewController(animated: true)
        navigateToLogin()
    }
    
    func navigateToNewPrescriptions() {
        let prescriptionViewController = viewControllerFactory.makePrescriptionViewController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(prescriptionViewController, animated: true)
    }
}
