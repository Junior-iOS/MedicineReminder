//
//  ViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
        
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGesture()
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        splashView.addGestureRecognizer(tapGesture)
    }

    @objc private func showLoginBottomSheet() {
        let loginBottomSheet = LoginBottomSheetViewController()
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        self.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateBottomSheet()
        }
    }
}
