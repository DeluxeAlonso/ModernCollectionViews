//
//  CompositionalLayoutTopicViewFactory.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

struct CompositionalLayoutTopicViewFactory: CompositionalLayoutTopicViewFactoryProtocol {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self.gridSection()
            case 1:
                return self.listSection()
            default:
                return nil
            }
        }
    }
    
    private func gridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func listSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
