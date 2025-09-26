//
//  HomeViewController.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import UIKit

protocol HomeFlowDelegate: AnyObject {
    // Define navigation methods for Home flow if needed
}

final class HomeViewController: UIViewController {
    
    private let homeView: HomeView
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(view: HomeView, delegate: LoginBottomSheetFlowDelegate) {
        self.homeView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
