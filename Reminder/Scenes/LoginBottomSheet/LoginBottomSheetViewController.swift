//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

final class LoginBottomSheetViewController: UIViewController {
    
    private let loginBottomSheetView = LoginBottomSheetView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    private func setupUI() {
        self.view.addSubview(loginBottomSheetView)
        loginBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginBottomSheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginBottomSheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginBottomSheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heightAnchor = loginBottomSheetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupGesture() {
        
    }
    
    private func handlePanGesture() {
        
    }
    
    func animateBottomSheet(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        loginBottomSheetView.transform = CGAffineTransform(translationX: 0, y: loginBottomSheetView.frame.height)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loginBottomSheetView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
}
