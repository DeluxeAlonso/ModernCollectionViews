//
//  Appearance+Title.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

extension UICollectionLayoutListConfiguration.Appearance {

    var title: String? {
        switch self {
        case .grouped: return "Grouped"
        case .insetGrouped: return "Inset grouped"
        case .plain: return "Plain"
        case .sidebar: return "Sidebar"
        case .sidebarPlain: return "Sidebar plain"
        @unknown default: return "Unknown"
        }
    }

}
