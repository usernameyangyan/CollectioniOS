//
//  SQLiteVersionMigrate.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/15.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

var versionMigrate: SQLiteVersionMigrate?
var table:String?

open class SQLiteVersionMigrate{
    
    private static let versionKey="yy_library_db_version"
    private static let isFirstUseKey="yy_library_db_use_key"
    
    
    
    public typealias Migrate = ((_ oldVersion:Int,_ newVersion:Int)->Void)?
    
    public static func setDbVersion(dbName:String,dbVersion:Int,migrate:Migrate){
        
        SQLiteDataBase.createDB(dbName)
        
        let version=DataManager.DataForUserDefaults<Int>.queryObjectForKey(key: versionKey)
         let isFirstResult=DataManager.DataForUserDefaults<Bool>.queryObjectForKey(key: isFirstUseKey)
        if(isFirstResult.result == false){
            DataManager.DataForUserDefaults<Bool>.saveObjectForKey(key: isFirstUseKey, object: true)
            DataManager.DataForUserDefaults<Int>.saveObjectForKey(key: versionKey, object: dbVersion)
        }
    
        
        if(dbVersion > version.result! && isFirstResult.result == true){
            migrate!(version.result!,dbVersion)
            DataManager.DataForUserDefaults<Int>.saveObjectForKey(key: versionKey, object: dbVersion)
        }
    }
    
    
    public class func with(cls:AnyClass) -> SQLiteVersionMigrate {
        let spilts=NSStringFromClass(cls).split(separator: ".")
        table=String(spilts[spilts.count-1])
        versionMigrate=SQLiteVersionMigrate()
        return versionMigrate!
    }
    
    private init(){
        
    }
    
    public func addAttribute(attribute:String,dataType: Any.Type,isNull:Bool=true)->SQLiteVersionMigrate{
        
        
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(table!)
        
        if SQLiteDataBase.shared.tableExists(tableName: tableFinalName) == true {
            let type=SQLiteDataBaseTool.sqlType(dataType)
            var sql=""
            if(isNull){
                sql="alter table \(table!) add \(attribute) \(type)"
            }else{
                sql="alter table \(table!) add \(attribute) \(type) not null"
            }
            
            SQLiteDataBase.shared.execute(sql)
            
            print(sql)
        }
        
        return self
        
    }
    
    open func build(){}
    
}
