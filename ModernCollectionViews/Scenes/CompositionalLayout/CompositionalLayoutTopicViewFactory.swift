//
//  CompositionalLayoutTopicViewFactory.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

struct CompositionalLayoutTopicViewFactory: CompositionalLayoutTopicViewFactoryProtocol {
    
    func makeCollectionViewLayouts() -> [LayoutProtocol] {
        return [SquareLayout(), NestedGroupLayout(), NestedGroupV2Layout(), ListLayout()]
    }
    
}
