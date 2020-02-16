//
//  SqliteData.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/13.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

@objcMembers
class SqliteData: SQLiteModel,Convertible{
    
    
    var des:String=""
    var id:Int=0
    
    override func primaryKey() -> String {
        return "id"
    }
   
}
