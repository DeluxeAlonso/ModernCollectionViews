//
//  MainCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/8/20.
//

import UIKit

protocol MainCoordinatorProtocol: class {
    
}

final class MainCoordinator: NSObject, MainCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel: MainViewModelProtocol = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        
        viewController.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
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
