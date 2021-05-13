//
//  MainProtocols.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/14/20.
//

import UIKit

protocol MainViewModelProtocol {

    func topics(for section: MainViewSection) -> [Topic]
    func topic(for index: Int, at section: MainViewSection) -> Topic

}

protocol MainCoordinatorProtocol: AnyObject {

    func showTopic(_ topic: Topic)

}

protocol MainViewFactoryProtocol {
    
    var sections: [MainViewSection] { get }
    
    func topic(for index: Int, at section: Int) -> Topic? 
    
}
