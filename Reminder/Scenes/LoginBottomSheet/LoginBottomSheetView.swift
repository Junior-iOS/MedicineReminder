//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import Foundation
import UIKit

final class LoginBottomSheetView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.heading
        label.text = "WELCOME_TITLE".localized
        return label
    }()
    
    private lazy var handleArea: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.little
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EMAIL_TITLE".localized
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "EMAIL_PLACEHOLDER".localized
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stackView.axis = .vertical
        stackView.spacing = Metrics.tiny
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PASSWORD_TITLE".localized
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "PASSWORD_PLACEHOLDER".localized
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = Metrics.tiny
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView])
        stackView.axis = .vertical
        stackView.spacing = Metrics.small
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUTTON_TITLE".localized, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Metrics.medium
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = Metrics.small
        
        addSubviews(titleLabel, handleArea, mainStackView, loginButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            handleArea.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
            handleArea.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            handleArea.widthAnchor.constraint(equalToConstant: 40),
            handleArea.heightAnchor.constraint(equalToConstant: 6),
            
            titleLabel.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.medium),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            
            emailTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.textFieldHeight),
            passwordTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.textFieldHeight),
            
            loginButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: Metrics.medium),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            loginButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.huge),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize)
        ])
    }
}
