//
//  SplashView.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

final class SplashView: UIView {
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(icon: .crossCaseCircleFill)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reminder"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: Metrics.large, weight: .bold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoView, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Metrics.little
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupUI() {
        backgroundColor = Colors.primaryRedBase
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            logoView.widthAnchor.constraint(equalToConstant: Metrics.large),
            logoView.heightAnchor.constraint(equalToConstant: Metrics.large)
        ])
    }
}
