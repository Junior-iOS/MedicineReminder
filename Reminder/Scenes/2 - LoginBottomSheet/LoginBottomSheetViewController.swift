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
    
    private let loginBottomSheetView: LoginBottomSheetView
    private let viewModel = LoginBottomSheetViewModel()
    public weak var delegate: LoginBottomSheetFlowDelegate?
    private var bottomSheetBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        bindViewModel()
        setupTapToDismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    init(view: LoginBottomSheetView, delegate: LoginBottomSheetFlowDelegate) {
        self.loginBottomSheetView = view
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
        bottomSheetBottomConstraint = loginBottomSheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            loginBottomSheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginBottomSheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomSheetBottomConstraint!
        ])
    }
    
    private func bindViewModel() {
        viewModel.successResult = { [weak self] user in
            self?.presentSavedLoginAlert(user: user)
        }
        
        viewModel.errorResult = { [weak self] error in
            self?.presentErrorAlert(message: error)
        }
    }
    
    private func presentSavedLoginAlert(user: String) {
        let alert = UIAlertController(title: "Salvar Acesso", message: "Deseja salvar seu acesso?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
            let user = User(email: user, isUserLoggedIn: true)
            UserDefaultsManager.shared.save(user)
            self.delegate?.navigateToHome()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            self.delegate?.navigateToHome()
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro de Autenticação", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
    
    private func setupTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Keyboard Observers
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height / 1.5
        bottomSheetBottomConstraint?.constant = -keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        bottomSheetBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.authenticate(user: user, password: password)
    }
}
