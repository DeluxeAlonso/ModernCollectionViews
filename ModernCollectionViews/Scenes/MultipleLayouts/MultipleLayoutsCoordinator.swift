//
//  MultipleLayoutsCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/22/21.
//

import UIKit

protocol MultipleLayoutsCoordinatorProtocol: AnyObject {}

final class MultipleLayoutsCoordinator: Coordinator, MultipleLayoutsCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let factory = MultipleLayoutsViewFactory()
        let viewController = MultipleLayoutsViewController(factory: factory)

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
