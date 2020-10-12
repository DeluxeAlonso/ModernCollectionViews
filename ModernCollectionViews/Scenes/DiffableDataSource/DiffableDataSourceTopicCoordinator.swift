//
//  DiffableDataSourceTopicCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/11/20.
//

import UIKit

protocol DiffableDataSourceTopicCoordinatorProtocol: class {
    
}

final class DiffableDataSourceTopicCoordinator: Coordinator, DiffableDataSourceTopicCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DiffableDataSourceTopicViewModel()
        let factory = DiffableDataSourceTopicViewFactory()
        let viewController = DiffableDataSourceTopicViewController(viewModel: viewModel,
                                                                   factory: factory)
        
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

