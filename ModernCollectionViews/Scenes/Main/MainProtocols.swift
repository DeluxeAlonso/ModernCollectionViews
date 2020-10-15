//
//  MainProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import UIKit

protocol MainViewModelProtocol {
    func topics(for section: Section) -> [Topic]
    func topic(for index: Int, at section: Section) -> Topic
}

protocol MainCoordinatorProtocol: class {
    func showTopic(_ topic: Topic)
}
