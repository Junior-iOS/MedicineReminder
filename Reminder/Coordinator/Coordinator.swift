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
    private let viewControllerFactory: FactoryViewControllers
    
    // MARK: - Init
    init() {
        self.viewControllerFactory = FactoryViewControllers()
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

// MARK: - HOME
extension Coordinator: HomeFlowDelegate {
    func logout() {
        self.navigationController?.popToRootViewController(animated: true)
        navigateToLogin()
    }
    
    func navigateToPrescriptions() {
        let myPrescriptionsViewController = viewControllerFactory.makePrescriptionViewController(flowDelegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(myPrescriptionsViewController, animated: true)
    }
    
    func navigateToNewPrescriptions() {
        let newPrescriptionViewController = viewControllerFactory.makeNewPrescriptionViewController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(newPrescriptionViewController, animated: true)
    }
}

// MARK: - MY PRESCRIPTIONS
extension Coordinator: PrescriptionsFlowDelegate {
    func popScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToNewPrescriptions() {
        navigateToNewPrescriptions()
    }
}
