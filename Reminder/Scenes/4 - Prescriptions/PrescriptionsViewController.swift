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
    
    private func setupTableView() {
        prescriptionView.tableView.delegate = self
        prescriptionView.tableView.dataSource = self
    }
    
    private func loadData() {
        viewModel.fetchData()
        prescriptionView.tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionsCell.identifier, for: indexPath) as? PrescriptionsCell else {
            return UITableViewCell()
        }
        
        let prescription = viewModel.prescriptions[indexPath.section]
        cell.configure(with: prescription)
        cell.onDelete = { [weak self] in
            guard let self else { return }
            
            if let currentIndexPath = tableView.indexPath(for: cell) {
                if currentIndexPath.section < viewModel.prescriptions.count {
                    self.viewModel.deletePrescription(by: viewModel.prescriptions[currentIndexPath.section].id)
                    self.viewModel.prescriptions.remove(at: currentIndexPath.section)
                    
                    tableView.deleteSections(IndexSet(integer: currentIndexPath.section), with: .automatic)
                }
            } else {
                print("Index out of Range")
            }
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
}
