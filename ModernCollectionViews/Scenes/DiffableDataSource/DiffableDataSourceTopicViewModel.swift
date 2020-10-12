//
//  DiffableDataSourceTopicViewModel.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/12/20.
//

import Foundation
import Combine

protocol DiffableDataSourceTopicViewModelProtocol {
    
    var numbersPublisher: Published<[Int]>.Publisher { get }
    
    func selectAllNumbers()
    func selectOddNumbers()
    func selectEvenNumbers()
    
}

class DiffableDataSourceTopicViewModel: DiffableDataSourceTopicViewModelProtocol {
    
    @Published var numbersToDisplay: [Int] = []
    
    var numbersPublisher: Published<[Int]>.Publisher {
        $numbersToDisplay
    }
    
    private let numbers = Array(0..<100)
    
    func selectAllNumbers() {
        numbersToDisplay = numbers
    }
    
    func selectOddNumbers() {
        numbersToDisplay = numbers.oddNumbers
    }
    
    func selectEvenNumbers() {
        numbersToDisplay = numbers.evenNumbers
    }
    
}
