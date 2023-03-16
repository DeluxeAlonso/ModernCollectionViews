//
//  CellRegistrationCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

protocol CellRegistrationCoordinatorProtocol: AnyObject {}

final class CellRegistrationCoordinator: Coordinator, CellRegistrationCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CellRegistrationViewController()

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
