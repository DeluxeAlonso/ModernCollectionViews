//
//  CompositionalLayoutTopicCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/11/20.
//

import UIKit

final class CompositionalLayoutTopicCoordinator: Coordinator, CompositionalLayoutTopicCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let factory = CompositionalLayoutTopicViewFactory()
        let viewController = CompositionalLayoutTopicViewController(factory: factory)
        
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
