//
//  Array+Filtering.swift
//  ModernCollectionViews
//
//  Created by Alonso Yoshio Alvarez Tengan on 10/5/20.
//

import Foundation

extension Array where Iterator.Element: BinaryInteger {
    
    var oddNumbers: Self {
        return filter { $0 % 2 != 0 }
    }
    
    var evenNumbers: Self {
        return filter { $0 % 2 == 0 }
    }
    
}
