//
//  OddEvenNumbersViewModel.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/12/20.
//

import Foundation
import Combine

final class OddEvenNumbersViewModel: OddEvenNumbersViewModelProtocol {
    
    @Published var numbersToDisplay: [Int] = []
    
    var numbersPublisher: Published<[Int]>.Publisher {
        $numbersToDisplay
    }
    
    private let numbers: [Int]
    
    init(numbers: [Int]) {
        self.numbers = numbers
    }
    
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
