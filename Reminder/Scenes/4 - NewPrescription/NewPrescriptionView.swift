//
//  NewPrescriptionView.swift
//  Reminder
//
//  Created by NJ Development on 21/10/25.
//

import UIKit

final class NewPrescriptionView: UIView {
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .arrowLeft), for: .normal)
        button.tintColor = Colors.gray100
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nova receita"
        label.textColor = Colors.primaryRedBase
        label.font = Typography.heading
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione sua prescrição médica para receber lembretes quando necessário."
        label.textColor = Colors.gray200
        label.font = Typography.body
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.setTitleColor(Colors.gray800, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var medicineInput: InputView = {
        return InputView(title: "Remédio", placeholder: "Nome do remédio")
    }()
    
    private lazy var timeInput: InputView = {
        return InputView(title: "Horário", placeholder: "12:00")
    }()
    
    private lazy var recurrenceInput: InputView = {
        return InputView(title: "Recorrência", placeholder: "Selecione")
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [medicineInput, timeInput, recurrenceInput])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var checkBox: CheckBoxView = {
        return CheckBoxView(title: "Tomar agora")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupView() {
        backgroundColor = Colors.gray800
        addSubviews(
            backButton,
            titleLabel,
            descriptionLabel,
            inputStackView,
            checkBox,
            addButton,
        )
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            inputStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.medium),
            inputStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            checkBox.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: Metrics.small),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.small),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
