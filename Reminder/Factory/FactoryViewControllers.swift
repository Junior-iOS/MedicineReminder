//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation
import UIKit

protocol FactoryViewControllersProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makePrescriptionViewController(flowDelegate: PrescriptionsFlowDelegate) -> PrescriptionsViewController
    func makeNewPrescriptionViewController() -> NewPrescriptionViewController
}

final class FactoryViewControllers: FactoryViewControllersProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        SplashViewController(view: SplashView(), delegate: flowDelegate)
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        LoginBottomSheetViewController(view: LoginBottomSheetView(), delegate: flowDelegate)
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        HomeViewController(view: HomeView(), delegate: flowDelegate)
    }
    
    func makePrescriptionViewController(flowDelegate: PrescriptionsFlowDelegate) -> PrescriptionsViewController {
        PrescriptionsViewController(prescriptionView: PrescriptionsView(), flowDelegate: flowDelegate)
    }
    
    func makeNewPrescriptionViewController() -> NewPrescriptionViewController {
        NewPrescriptionViewController()
    }
}
