//
//  Topic.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import Foundation

enum Topic {
    
    case compositionalLayouts
    case diffableDataSources
    case collectionViewLists
    
    var title: String? {
        switch self {
        case .compositionalLayouts:
            return "UICollectionViewCompositionalLayout"
        case .diffableDataSources:
            return "UICollectionViewDiffableDataSource"
        case .collectionViewLists:
            return "Lists with collection views"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .compositionalLayouts:
            return "Declarative collection view layouts"
        case .diffableDataSources:
            return "Collaction view update's management"
        case .collectionViewLists:
            return "Cell registrations, list cells and content config"
        }
    }
    
}
