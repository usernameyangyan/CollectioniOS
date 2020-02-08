//
//  YYPageViewLayoutAttributes.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

open class YYPageViewLayoutAttributes: UICollectionViewLayoutAttributes {

    open var position: CGFloat = 0
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? YYPageViewLayoutAttributes else {
            return false
        }
        var isEqual = super.isEqual(object)
        isEqual = isEqual && (self.position == object.position)
        return isEqual
    }
    
    open override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! YYPageViewLayoutAttributes
        copy.position = self.position
        return copy
    }
    
}

