//
//  DiffableDataSourceCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/23/21.
//

import UIKit

protocol DiffableDataSourceCoordinatorProtocol: AnyObject {

    func showOddEvenNumbers()
    func showBluetoothSettings()

}

class DiffableDataSourceCoordinator: Coordinator, DiffableDataSourceCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = DiffableDataSourceViewController()

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func showOddEvenNumbers() {
        let coordinator = OddEvenNumbersCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showBluetoothSettings() {
        let coordinator = BluetoothSettingsCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}
