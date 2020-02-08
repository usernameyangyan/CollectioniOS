//
//  NSObject+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//
import Foundation

extension NSObject {
    static func newConvertible() -> Convertible {
        return self.init() as! Convertible
    }
}
