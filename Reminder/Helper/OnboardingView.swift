//
//  OnboardingView.swift
//  Reminder
//
//  Created by NJ Development on 16/12/25.
//

import Foundation
import UIKit

final class OnboardingView: UIView {
    private var steps: [String] = []
    private var currentStep = 0
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray100.withAlphaComponent(0.4)
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Typography.heading
        label.textColor = Colors.gray300
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.setTitleColor(Colors.primaryBlueBase, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        addSubviews(backgroundView, messageLabel, nextButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            nextButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Metrics.medium),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func presentOnboarding(on view: UIView, with steps: [String]) {
        self.steps = steps
        self.currentStep = 0
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateSteps() {
        messageLabel.text = steps[currentStep]
    }
    
    private func didTapNextStep() {
        guard currentStep < steps.count - 1 else {
            dismiss()
            return
        }
        
        currentStep += 1
        updateSteps()
    }
    
    private func dismiss() {
        removeFromSuperview()
    }
}
