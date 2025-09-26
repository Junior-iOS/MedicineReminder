//
//  ViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

protocol SplashFlowDelegate: AnyObject {
    func navigateToLogin()
    func navigateToHome()
}

final class SplashViewController: UIViewController {
    
    private let splashView: SplashView
    public weak var splashDelegate: SplashFlowDelegate?
        
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGesture()
        animateView()
    }
    
    init(view: SplashView, delegate: SplashFlowDelegate) {
        self.splashView = view
        self.splashDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        splashView.addGestureRecognizer(tapGesture)
    }

    @objc private func showLoginBottomSheet() {
        animateLogoUp()
        self.splashDelegate?.navigateToLogin()
    }
    
    private func checkNavigationFlow() {
        if let user = UserDefaultsManager.shared.loadUser(), user.isUserLoggedIn {
            self.splashDelegate?.navigateToHome()
        } else {
            showLoginBottomSheet()
        }
    }
}

// MARK: - ANIMATION
extension SplashViewController {
    private func animateView() {
        UIView.animate(withDuration: 1.5, delay: 0.0, animations: {
            self.splashView.stackView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            self.checkNavigationFlow()
        }
    }
    
    private func animateLogoUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.splashView.stackView.transform = CGAffineTransform(translationX: 0, y: -100)
        }, completion: nil)
    }
}
