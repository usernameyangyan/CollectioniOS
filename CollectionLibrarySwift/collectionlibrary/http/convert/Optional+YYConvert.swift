//
//  Optional+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

protocol OptionalValue {
    var yy_value: Any? { get }
}

extension Optional: OptionalValue {
    var yy_value: Any? {
        guard let v = self else { return nil }
        return (v as? OptionalValue)?.yy_value ?? v
    }
}
