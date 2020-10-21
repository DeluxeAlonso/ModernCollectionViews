//
//  MainViewFactory.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import Foundation

struct MainViewFactory: MainViewFactoryProtocol {
    
    var sections: [MainViewSection] {
        return [.iOS13, .iOS14]
    }
    
    func topic(for index: Int, at section: Int) -> Topic? {
        guard sections.count > section else { return nil }
        
        let section = sections[section]
        guard section.topics.count > index else { return  nil }
        
        return section.topics[index]
    }
    
}
