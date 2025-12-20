//
//  NewPrescriptionViewController.swift
//  Reminder
//
//  Created by NJ Development on 21/10/25.
//

import Lottie
import UIKit
import OnboardingKit

final class NewPrescriptionViewController: UIViewController {
    private let prescriptionView = NewPrescriptionView()
    private let viewModel = NewPrescriptionViewModel()
    private let onboardingView = OnboardingView()

    override func loadView() {
        view = prescriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentOnboarding()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setupButtons() {
        prescriptionView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        prescriptionView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    @objc private func didTapBackButton() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapAddButton() {
        let medicine = prescriptionView.medicineInput.getText()
        let time = prescriptionView.timeInput.getText()
        let recurrence = prescriptionView.recurrenceInput.getText()
        let prescription = Prescription(medicine: medicine, time: time, recurrence: RecurrenceOptions(rawValue: recurrence) ?? .onceADay)

        viewModel.addPrescription(
            prescription: prescription,
            shouldTakeItNow: prescriptionView.checkBox.checkBoxButton.hasCheckedState()
        )
        prescriptionView.clear()
        playSuccessAnimation()
    }

    private func playSuccessAnimation() {
        prescriptionView.lottieAnimation.isHidden = false
        prescriptionView.lottieAnimation.play { [weak self] completed in
            guard let self else { return }
            if completed {
                prescriptionView.lottieAnimation.isHidden = true
            }
        }
    }
    
    private func presentOnboarding() {
        if !UserDefaultsManager.shared.hasSeenOnboarding() {
            onboardingView.presentOnboarding(
                on: view,
                with: [
                    (image: UIImage(systemName: "hand.rays.fill"), text: "Toque para adicionar um medicamento"),
                    (image: UIImage(systemName: "clock.circle"), text: "Defina o horário do lembrete"),
                    (image: UIImage(systemName: "repeat.circle.fill"), text: "Escolha a recorrência")
                ]
            )
            UserDefaultsManager.shared.setHasSeenOnboarding()
        }
    }
}
