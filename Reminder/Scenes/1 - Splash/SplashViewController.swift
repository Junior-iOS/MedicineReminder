//
//  ViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

protocol SplashFlowDelegate: AnyObject {
    func navigateToLogin()
}

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    public weak var splashDelegate: SplashFlowDelegate?
        
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGesture()
    }
    
    init(delegate: SplashFlowDelegate) {
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
        self.splashDelegate?.navigateToLogin()
    }
}
