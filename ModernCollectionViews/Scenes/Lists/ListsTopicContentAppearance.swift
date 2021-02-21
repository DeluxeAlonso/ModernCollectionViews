//
//  ListsTopicContentConfiguration.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

enum ListsTopicContentAppearance: CaseIterable {

    case plain, grouped, insetGrouped

    var title: String? {
        switch self {
        case .plain:
            return "Plain"
        case .grouped:
            return "Grouped"
        case .insetGrouped:
            return "Inset grouped"
        }
    }

    var appearance: UICollectionLayoutListConfiguration.Appearance {
        switch self {
        case .plain:
            return .plain
        case .grouped:
            return .grouped
        case .insetGrouped:
            return .insetGrouped
        }
    }

}
