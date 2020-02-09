//
//  Shadow.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit
public struct Shadow {
    let color: CGColor?
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
    let path: CGPath?
    
    public static let none: Shadow = .init()
    
    public init(
        color: CGColor? = nil,
        opacity: Float = 0,
        offset: CGSize = CGSize(width: 0, height: -3),
        radius: CGFloat = 3,
        path: CGPath? = nil) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.path = path
    }
}

extension CALayer {
    
    func set(_ shadow: Shadow) {
        shadowColor = shadow.color
        shadowOpacity = shadow.opacity
        shadowOffset = shadow.offset
        shadowRadius = shadow.radius
        shadowPath = shadow.path
    }
}
