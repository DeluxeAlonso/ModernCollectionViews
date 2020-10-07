//
//  MainViewModel.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import Foundation

protocol MainViewModelProtocol {
    
    func topics(for section: Section) -> [Topic]
    func topic(for index: Int, at section: Section) -> Topic
    
}

struct MainViewModel: MainViewModelProtocol {
    
    func topics(for section: Section) -> [Topic] {
        switch section {
        case .iOS13:
            return [.compositionalLayouts, .diffableDataSources]
        case .iOS14:
            return [.collectionViewLists]
        }
    }
    
    func topic(for index: Int, at section: Section) -> Topic {
        let topics = self.topics(for: section)
        return topics[index]
    }
    
}
