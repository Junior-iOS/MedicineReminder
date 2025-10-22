//
//  NewPrescriptionViewController.swift
//  Reminder
//
//  Created by NJ Development on 21/10/25.
//

import UIKit

class NewPrescriptionViewController: UIViewController {
    
    private let prescriptionView = NewPrescriptionView()
    
    override func loadView() {
        view = prescriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackButton()
    }
    
    private func setupBackButton() {
        prescriptionView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
