//
//  PrescriptionsViewController.swift
//  Reminder
//
//  Created by NJ Development on 08/12/25.
//

import UIKit

protocol PrescriptionsFlowDelegate: AnyObject {
    func goToMyPrescriptions()
}

final class PrescriptionsViewController: UIViewController {
    private var prescriptionView = PrescriptionsView()
    weak var flowDelegate: PrescriptionsFlowDelegate?
    
    override func loadView() {
        self.view = prescriptionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(prescriptionView: PrescriptionsView, flowDelegate: PrescriptionsFlowDelegate) {
        self.prescriptionView = prescriptionView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        title = "Prescriptions"
        prescriptionView.delegate = self
    }
}

extension PrescriptionsViewController: PrescriptionsViewDelegate {
    func didTapBackButton() {
        print("didTapBackButton")
    }
    
    func didTapAddbutton() {
        print("didTapAddbutton")
    }
}
