//
//  OddEvenNumbersCoordinator.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/11/20.
//

import UIKit

final class OddEvenNumbersCoordinator: Coordinator, OddEvenNumbersCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = OddEvenNumbersViewModel(numbers: Array(0..<100))
        let factory = OddEvenNumbersViewFactory()
        let viewController = OddEvenNumbersViewController(viewModel: viewModel,
                                                                   factory: factory)
        
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

