//
//  CardView.swift
//  Reminder
//
//  Created by NJ Development on 17/10/25.
//

import Foundation
import UIKit

final class CardView: UIView {
    private let iconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = Metrics.small
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.subHeading
        label.textColor = Colors.gray100
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(icon: .chevronRight)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Colors.gray300
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(icon: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        setupView()
        configureUI(icon: icon, title: title, description: description)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        backgroundColor = Colors.gray700
        layer.cornerRadius = Metrics.medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureUI(icon: UIImage?, title: String, description: String) {
        self.iconImageView.image = icon
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    private func setupUI() {
        addSubviews(iconView, titleLabel, descriptionLabel, arrowImageView)
        iconView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.small),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Metrics.medium),
            
            arrowImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: Metrics.medium),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.small),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
