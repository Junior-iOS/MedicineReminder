//
//  PrescriptionsView.swift
//  Reminder
//
//  Created by NJ Development on 09/11/25.
//

import Foundation
import UIKit

protocol PrescriptionsViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapAddbutton()
}

final class PrescriptionsView: UIView {
    weak var delegate: PrescriptionsViewDelegate?
    
    private lazy var headerBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = Metrics.medium
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .arrowLeft), for: .normal)
        button.tintColor = Colors.gray100
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Minhas receitas"
        label.textColor = Colors.primaryBlueBase
        label.font = Typography.heading
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes."
        label.textColor = Colors.gray200
        label.font = Typography.body
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryBlueBase
        button.setTitleColor(Colors.gray800, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray800
        view.layer.cornerRadius = Metrics.medium
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        backgroundColor = Colors.gray800
        
        addSubviews(headerBackground, contentBackground)
        headerBackground.addSubviews(
            backButton,
            addButton,
            titleLabel,
            descriptionLabel
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackground.heightAnchor.constraint(equalToConstant: Metrics.profileBackgroundSize),
            
            contentBackground.topAnchor.constraint(equalTo: headerBackground.bottomAnchor, constant: -Metrics.large),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.large),
            backButton.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            addButton.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -Metrics.medium),
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
        ])
    }
    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    @objc private func didTapAddButton() {
        delegate?.didTapAddbutton()
    }
}
