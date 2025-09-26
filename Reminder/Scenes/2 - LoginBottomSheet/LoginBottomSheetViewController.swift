//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

protocol LoginBottomSheetFlowDelegate: AnyObject {
    func navigateToHome()
}

final class LoginBottomSheetViewController: UIViewController {
    
    private let loginBottomSheetView = LoginBottomSheetView()
    private let viewModel = LoginBottomSheetViewModel()
    public weak var delegate: LoginBottomSheetFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    init(delegate: LoginBottomSheetFlowDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        self.view.addSubview(loginBottomSheetView)
        loginBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        loginBottomSheetView.delegate = self
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
    
    private func bindViewModel() {
        viewModel.successResult = { [weak self] in
            self?.delegate?.navigateToHome()
        }
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

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.authenticate(user: user, password: password)
    }
}
