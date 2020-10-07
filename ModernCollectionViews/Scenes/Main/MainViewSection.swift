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
}
