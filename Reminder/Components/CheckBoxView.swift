//
//  CheckBoxView.swift
//  Reminder
//
//  Created by NJ Development on 22/10/25.
//

import UIKit
import OnboardingKit

final class CheckBoxView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray200
        label.font = Typography.input
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private(set) lazy var checkBoxButton: ToggleCheckBox = {
        let checkbox = ToggleCheckBox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
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
    required init?(coder _: NSCoder) { nil }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        setupConstraints()
        setupGesture()
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTitleLabelTap))
        titleLabel.addGestureRecognizer(tap)
    }
    
    @objc private func handleTitleLabelTap() {
        checkBoxButton.sendActions(for: .touchUpInside)
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
