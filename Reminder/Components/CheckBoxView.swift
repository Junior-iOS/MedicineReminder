//
//  CheckBoxView.swift
//  Reminder
//
//  Created by NJ Development on 22/10/25.
//

import UIKit

final class CheckBoxView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray200
        label.font = Typography.input
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .square), for: .normal)
        button.tintColor = Colors.gray400
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBoxButton, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        return stackView
    }()

    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            checkBoxButton.widthAnchor.constraint(equalToConstant: Metrics.medium),
            checkBoxButton.heightAnchor.constraint(equalToConstant: Metrics.medium)
        ])
    }
}
