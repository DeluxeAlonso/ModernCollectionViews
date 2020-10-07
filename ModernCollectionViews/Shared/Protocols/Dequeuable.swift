//
//  Dequeuable.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

protocol Dequeuable {
    
    static var dequeuIdentifier: String { get }
    
}

extension Dequeuable where Self: UIView {
    
    static var dequeuIdentifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionViewCell: Dequeuable { }
