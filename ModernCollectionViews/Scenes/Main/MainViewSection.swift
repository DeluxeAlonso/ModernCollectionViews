//
//  MainViewSection.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import Foundation

enum Section {
    case iOS13
    case iOS14
    
    var title: String? {
        switch self {
        case .iOS13:
            return "iOS 13"
        case .iOS14:
            return "iOS 14"
        }
    }
    
    var topics: [Topic] {
        switch self {
        case .iOS13:
            return [.compositionalLayouts, .diffableDataSources]
        case .iOS14:
            return [.collectionViewLists]
        }
    }
}

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
            return "Collection view update's management"
        case .collectionViewLists:
            return "Cell registrations, list cells and content config"
        }
    }
    
}
