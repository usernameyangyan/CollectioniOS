//
//  result.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/3.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class Result<T>:Convertible{
   
    var code:Int=0
    var message:String=""
    var result:T?=nil
    
    required init() {
    }
}
