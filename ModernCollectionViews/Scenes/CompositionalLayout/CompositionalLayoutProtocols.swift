//
//  CompositionalLayoutProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

protocol CompositionalLayoutTopicViewFactoryProtocol {
    func makeCollectionViewLayouts() -> [LayoutProtocol]
}

protocol CompositionalLayoutTopicCoordinatorProtocol: AnyObject {}
