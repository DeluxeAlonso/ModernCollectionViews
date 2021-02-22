//
//  OtherCapabilitiesCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

protocol OtherCapabilitiesCoordinatorProtocol: class {

}

final class OtherCapabilitiesCoordinator: Coordinator, OtherCapabilitiesCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = OtherCapabilitiesViewController()

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
