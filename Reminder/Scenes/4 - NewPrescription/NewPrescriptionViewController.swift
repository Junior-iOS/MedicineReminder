//
//  NewPrescriptionViewController.swift
//  Reminder
//
//  Created by NJ Development on 21/10/25.
//

import UIKit

class NewPrescriptionViewController: UIViewController {
    private let prescriptionView = NewPrescriptionView()
    private let viewModel = NewPrescriptionViewModel()
    
    override func loadView() {
        view = prescriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackButton()
    }
    
    private func setupBackButton() {
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
        
        viewModel.addPrescription(medicine: medicine, time: time, recurrence: recurrence, shouldTakeItNow: false)
        print("Added prescription: \(medicine)")
        prescriptionView.clear()
    }
}
