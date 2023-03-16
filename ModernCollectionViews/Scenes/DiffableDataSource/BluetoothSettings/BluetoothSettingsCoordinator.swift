//
//  BluetoothSettingsCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/23/21.
//

import UIKit

protocol BluetoothSettingsCoordinatorProtocol: AnyObject {}

final class BluetoothSettingsCoordinator: Coordinator, BluetoothSettingsCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = BluetoothSettingsViewController()

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
