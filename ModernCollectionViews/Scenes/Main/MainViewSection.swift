//
//  MainViewSection.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

enum MainViewSection {
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
            return [.collectionViewLists, .cellRegistration, .multipleLayouts, .otherCapabilities]
        }
    }
}

enum Topic {
    
    case compositionalLayouts
    case diffableDataSources
    case collectionViewLists
    case cellRegistration
    case multipleLayouts
    case otherCapabilities
    
    var title: String? {
        switch self {
        case .compositionalLayouts:
            return "UICollectionViewCompositionalLayout"
        case .diffableDataSources:
            return "UICollectionViewDiffableDataSource"
        case .collectionViewLists:
            return "Lists with collection views"
        case .cellRegistration:
            return "Cell registration"
        case .multipleLayouts:
            return "Multiple layouts"
        case .otherCapabilities:
            return "Other capabilities"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .compositionalLayouts:
            return "Declarative collection view layouts"
        case .diffableDataSources:
            return "Collection view update's management"
        case .collectionViewLists:
            return "List cell, Content config and Layout list config"
        case .cellRegistration, .multipleLayouts:
            return nil
        case .otherCapabilities:
            return "Drag and drop and section snapshot"
        }
    }
    
}
