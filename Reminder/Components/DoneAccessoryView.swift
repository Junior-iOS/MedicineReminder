//
//  DoneAccessoryView.swift
//  Reminder
//
//  Created by NJ Development on 09/11/25.
//

import UIKit

final class DoneAccessoryView: UIView {
    var onDoneTapped: (() -> Void)?

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground

        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.tintColor = Colors.gray100
        button.addAction(UIAction { [weak self] _ in
            self?.onDoneTapped?()
        }, for: .touchUpInside)

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.default),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }
}
