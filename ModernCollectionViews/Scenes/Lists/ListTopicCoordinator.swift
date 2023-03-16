//
//  ListTopicCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/11/20.
//

import UIKit

protocol ListTopicCoordinatorProtocol: Coordinator {}

final class ListTopicCoordinator: ListTopicCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ListsTopicViewController()
        
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
