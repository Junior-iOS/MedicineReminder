//
//  HomeView.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapProfileImage()
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private lazy var profileBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = Metrics.medium
        return view
    }()
    
    private(set) lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(icon: .personCropCircleFill)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Metrics.profileImageSize / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HOME_WELCOME_TITLE".localized
        label.textColor = Colors.gray200
        label.font = Typography.input
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "HOME_NAME_PLACEHOLDER".localized
        textField.textColor = Colors.gray100
        textField.font = Typography.subHeading
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.delegate = self
        textField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var contentBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var feedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HOME_FEEDBACK_BUTTON".localized, for: .normal)
        button.backgroundColor = Colors.gray100
        button.setTitleColor(Colors.gray800, for: .normal)
        button.layer.cornerRadius = Metrics.medium
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var prescriptionCardView: CardView = {
        let card = CardView(
            icon: UIImage(icon: .newsPaper),
            title: "Minhas receitas",
            description: "Acompanhe os medicamentos e gerencie lembretes"
        )
        return card
    }()
    
    private(set) lazy var newPrescriptionCardView: CardView = {
        let card = CardView(
            icon: UIImage(icon: .pills),
            title: "Nova receita",
            description: "Cadastre novos lembretes de receitas"
        )
        card.tintColor = Colors.primaryRedBase
        return card
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        backgroundColor = Colors.gray600
        addSubviews(profileBackground, contentBackground)
        profileBackground.addSubviews(profileImageView, welcomeLabel, nameTextField)
        contentBackground.addSubviews(feedbackButton, prescriptionCardView, newPrescriptionCardView)
        
        setupConstraints()
        setupImageTapGesture()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: Metrics.profileBackgroundSize),
            
            profileImageView.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: Metrics.huge),
            profileImageView.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
            profileImageView.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Metrics.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.little),
            nameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: profileBackground.trailingAnchor, constant: -Metrics.medium),
            
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor, constant: -Metrics.huge),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            
            prescriptionCardView.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            prescriptionCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            prescriptionCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            prescriptionCardView.heightAnchor.constraint(equalToConstant: 100),
            
            newPrescriptionCardView.topAnchor.constraint(equalTo: prescriptionCardView.bottomAnchor, constant: Metrics.large),
            newPrescriptionCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            newPrescriptionCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            newPrescriptionCardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }
    
    @objc private func didEndEditing() {
        if let name = nameTextField.text, name != "" {
            UserDefaultsManager.shared.saveUserName(name)
        } else {
            UserDefaultsManager.shared.saveUserName("")
        }
    }
    
    func updateView(with name: String, and image: UIImage?) {
        if name != "" {
            nameTextField.text = name
        } else {
            nameTextField.placeholder = "HOME_NAME_PLACEHOLDER".localized
        }
        
        if let image = image {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(icon: .personCropCircleFill)
        }
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
