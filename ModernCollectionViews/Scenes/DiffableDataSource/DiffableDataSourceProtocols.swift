//
//  DiffableDataSourceProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import UIKit
import Combine

protocol DiffableDataSourceTopicViewModelProtocol {
    var numbersPublisher: Published<[Int]>.Publisher { get }
    
    func selectAllNumbers()
    func selectOddNumbers()
    func selectEvenNumbers()
}

protocol DiffableDataSourceTopicCoordinatorProtocol: class {}

protocol DiffableDataSourceTopicViewFactoryProtocol {
    func makeCollectionViewLayout() -> UICollectionViewLayout
}
