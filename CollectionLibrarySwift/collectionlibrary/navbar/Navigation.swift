//
//  Navigation.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//
import UIKit

public struct Navigation<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol NavigationCompatible {
    
    associatedtype CompatibleType
    
    var navigation: CompatibleType { get }
}

public extension NavigationCompatible {
    
    var navigation: Navigation<Self> {
        return Navigation(self)
    }
}

extension UIViewController: NavigationCompatible {}
