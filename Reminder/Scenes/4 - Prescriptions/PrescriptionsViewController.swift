//
//  PrescriptionsViewController.swift
//  Reminder
//
//  Created by NJ Development on 08/12/25.
//

import UIKit

protocol PrescriptionsFlowDelegate: AnyObject {
    func goToNewPrescriptions()
    func popScreen()
}

final class PrescriptionsViewController: UIViewController {
    private var prescriptionView = PrescriptionsView()
    private let viewModel = PrescriptionsViewModel()
    weak var flowDelegate: PrescriptionsFlowDelegate?

    override func loadView() {
        self.view = prescriptionView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bindViewModel()
    }

    init(prescriptionView: PrescriptionsView, flowDelegate: PrescriptionsFlowDelegate) {
        self.prescriptionView = prescriptionView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { nil }

    private func setupView() {
        title = "Prescriptions"
        prescriptionView.delegate = self
    }

    private func setupTableView() {
        prescriptionView.tableView.delegate = self
        prescriptionView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.onDataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.prescriptionView.tableView.reloadData()
            }
        }
    }

    private func loadData() {
        viewModel.fetchData()
    }
}

extension PrescriptionsViewController: PrescriptionsViewDelegate {
    func didTapBackButton() {
        flowDelegate?.popScreen()
    }

    func didTapAddbutton() {
        flowDelegate?.goToNewPrescriptions()
    }
}

extension PrescriptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        viewModel.prescriptions.count
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionsCell.identifier, for: indexPath) as? PrescriptionsCell else {
            return UITableViewCell()
        }

        let prescription = viewModel.prescriptions[indexPath.section]
        cell.configure(with: prescription)
        cell.onDelete = { [weak self] in
            guard let self = self else { return }

            if let currentIndexPath = tableView.indexPath(for: cell) {
                self.viewModel.deletePrescription(at: currentIndexPath.section)
            }
        }

        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        90
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        4
    }
}
