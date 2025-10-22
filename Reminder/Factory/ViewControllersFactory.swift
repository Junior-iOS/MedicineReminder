//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import Foundation
import UIKit

protocol ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makePrescriptionViewController() -> NewPrescriptionViewController
}

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let splashView = SplashView()
        return SplashViewController(view: splashView, delegate: flowDelegate)
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let loginBottomSheetView = LoginBottomSheetView()
        return LoginBottomSheetViewController(view: loginBottomSheetView, delegate: flowDelegate)
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let homeView = HomeView()
        return HomeViewController(view: homeView, delegate: flowDelegate)
    }
    
    func makePrescriptionViewController() -> NewPrescriptionViewController {
        return NewPrescriptionViewController()
    }
}

