//
//  MainCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/8/20.
//

import UIKit

protocol MainCoordinatorProtocol: class {
    
}

final class MainCoordinator: MainCoordinatorProtocol {
    
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
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
