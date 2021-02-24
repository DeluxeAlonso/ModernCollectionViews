//
//  BluetoothItem.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/23/21.
//

import Foundation

enum BluetoothItem: Hashable {
    case enable, available(title: String)

    var title: String {
        switch self {
        case .enable:
            return "Bluetooth"
        case .available(let title):
            return title
        }
    }
}
