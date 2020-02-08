//
//  YY.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit


public protocol YYExtensionsProvider: class {
    associatedtype CompatibleType
    var yy: CompatibleType { get }
}

extension YYExtensionsProvider {
    /// A proxy which hosts reactive extensions for `self`.
    public var yy: YY<Self> {
        return YY(self)
    }

}

public struct YY<Base> {
    public let base: Base
    
    // Construct a proxy.
    //
    // - parameters:
    //   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

//
extension UIScrollView: YYExtensionsProvider {}



