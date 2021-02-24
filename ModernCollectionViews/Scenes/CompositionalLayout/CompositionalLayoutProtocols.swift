//
//  CompositionalLayoutProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import UIKit

protocol CompositionalLayoutTopicViewFactoryProtocol {
    func makeCollectionViewLayouts() -> [LayoutProtocol]
}

protocol CompositionalLayoutTopicCoordinatorProtocol: class {}
