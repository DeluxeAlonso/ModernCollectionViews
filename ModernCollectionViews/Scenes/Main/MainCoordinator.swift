//
//  MainCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/8/20.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator, MainCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let factory = MainViewFactory()
        let viewController = MainViewController(factory: factory)
        
        viewController.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showTopic(_ topic: Topic) {
        let coordinator: Coordinator
        
        switch topic {
        case .collectionViewLists:
            coordinator = ListTopicCoordinator(navigationController: navigationController)
        case .compositionalLayouts:
            coordinator = CompositionalLayoutTopicCoordinator(navigationController: navigationController)
        case .diffableDataSources:
            coordinator = DiffableDataSourceCoordinator(navigationController: navigationController)
        case .cellRegistration:
            coordinator = CellRegistrationCoordinator(navigationController: navigationController)
        case .multipleLayouts:
            coordinator = MultipleLayoutsCoordinator(navigationController: navigationController)
        case .otherCapabilities:
            coordinator = OtherCapabilitiesCoordinator(navigationController: navigationController)
        }
        
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}

// MARK: - UINavigationControllerDelegate

extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        parentCoordinator?.childDidFinish()
    }
    
}
