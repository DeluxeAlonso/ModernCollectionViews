//
//  CellRegistrationTopicCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

protocol CellRegistrationTopicCoordinatorProtocol: class {

}

final class CellRegistrationTopicCoordinator: Coordinator, CellRegistrationTopicCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CellRegistrationTopicViewController()

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
