//
//  OtherCapabilitiesItemModel.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/22/21.
//

import Foundation

struct RowModel: Hashable {

    let identifier = UUID()
    let value: Int

}

struct SectionModel: Hashable {

    let identifier = UUID()
    let value: Int

}

enum Item: Hashable {

    case sectionItem(model: SectionModel)
    case rowItem(model: RowModel)

    var value: Int {
        switch self {
        case .sectionItem(let model):
            return model.value
        case .rowItem(let model):
            return model.value
        }
    }

}
