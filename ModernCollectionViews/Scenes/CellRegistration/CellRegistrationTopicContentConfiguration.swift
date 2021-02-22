//
//  CellRegistrationContentConfiguration.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

enum CellRegistrationContentConfiguration: CaseIterable {

    case subtitle, value

    var title: String {
        switch self {
        case .subtitle:
            return "Subtitle cell"
        case .value:
            return "Value cell"
        }
    }

    var configuration: UIListContentConfiguration {
        switch self {
        case .subtitle:
            return .subtitleCell()
        case .value:
            return .valueCell()
        }
    }

}
