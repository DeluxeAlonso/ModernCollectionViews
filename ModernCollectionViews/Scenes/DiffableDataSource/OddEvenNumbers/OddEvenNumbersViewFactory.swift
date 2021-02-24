//
//  OddEvenNumbersViewFactory.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

struct OddEvenNumbersViewFactory: OddEvenNumbersViewFactoryProtocol {
    
    private var topItem: NSCollectionLayoutItem {
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalWidth(0.5))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        return topItem
    }
    
    private var bottomItem: NSCollectionLayoutItem {
        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        return bottomItem
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {

        // Group for bottom item, it repeats the bottom item twice
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalWidth(0.5))
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize,
                                                             subitem: bottomItem, count: 2)

        // Combine the top item and bottom group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize,
                                                           subitems: [topItem, bottomGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
}
