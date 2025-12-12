//
//  PrescriptionsCell.swift
//  Reminder
//
//  Created by NJ Development on 09/12/25.
//

import UIKit

final class PrescriptionsCell: UITableViewCell {
    var onDelete: (() -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray200
        label.font = Typography.subHeading
        return label
    }()
    
    private(set) lazy var trashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .trash), for: .normal)
        button.tintColor = Colors.primaryRedBase
        button.addTarget(self, action: #selector(didTapDeletePrescription), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, trashButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        return stackView
    }()
    
    private let watchImageView: UIImageView = {
        let imageView = UIImageView(icon: .clock)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray300
        return imageView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray100
        label.font = Typography.tag
        return label
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [watchImageView, timeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        stackView.backgroundColor = Colors.gray500
        return stackView
    }()
    
    private let recurrenceImageView: UIImageView = {
        let imageView = UIImageView(icon: .repeat)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray300
        return imageView
    }()
    
    private lazy var recurrenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray100
        label.font = Typography.tag
        return label
    }()
    
    private lazy var recurrenceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recurrenceImageView, recurrenceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        stackView.backgroundColor = Colors.gray500
        return stackView
    }()
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeStackView, recurrenceStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, backgroundStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.tiny
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        contentView.backgroundColor = Colors.gray700
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Metrics.small
        contentView.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.small),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.small),
            
            watchImageView.widthAnchor.constraint(equalToConstant: Metrics.medium),
            watchImageView.heightAnchor.constraint(equalToConstant: Metrics.medium),
            recurrenceImageView.widthAnchor.constraint(equalToConstant: Metrics.medium),
            recurrenceImageView.heightAnchor.constraint(equalToConstant: Metrics.medium)
        ])
    }
    
    @objc private func didTapDeletePrescription() {
        onDelete?()
    }
    
    func configure(with prescription: Prescription) {
        titleLabel.text = prescription.medicine
        timeLabel.text = prescription.time
        recurrenceLabel.text = prescription.recurrence
    }
}
