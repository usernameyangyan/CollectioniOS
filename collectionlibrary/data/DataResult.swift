//
//  DataResult.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

open class DataResult<T>:Convertible{
    public var result:T?=nil
    
    public required init() {
        
    }
}
