//
//  OddEvenNumbersProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import UIKit
import Combine

protocol OddEvenNumbersViewModelProtocol {

    var numbersPublisher: Published<[Int]>.Publisher { get }
    
    func selectAllNumbers()
    func selectOddNumbers()
    func selectEvenNumbers()

}

protocol OddEvenNumbersCoordinatorProtocol: AnyObject {}

protocol OddEvenNumbersViewFactoryProtocol {

    func makeCollectionViewLayout() -> UICollectionViewLayout

}
