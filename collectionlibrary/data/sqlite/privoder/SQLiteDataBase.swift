//
//  SQLiteDataBase.swift
//  AutoSQLite.swift
//
//  Created by QJ Technology on 2017/5/11.
//  Copyright © 2017年 TonyReet. All rights reserved.
//

import Foundation


open class SQLiteDataBase: NSObject {
    //创建单例
    public static let shared           = SQLiteDataBase()
    
    fileprivate let default_DataBase_Name   = "database"
    
    fileprivate var database: Connection?
    
    fileprivate var databasePath: String?
    
    fileprivate var databaseName: String?
    
    fileprivate var dataBaseTables:[String : Table] = [:]
    
    // MARK: - 类方法
    // 初始化db
    public  class func createDB(_ dataBaseName: String ) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        let defaultPath = sqliteDataBase.defaultPath()
        
        if sqliteDataBase.checkNameIsVerify(dataBaseName) {
            
            let databaseName = SQLiteDataBaseTool.removeBlankSpace(dataBaseName)
            
            sqliteDataBase.databaseName = databaseName
            sqliteDataBase.database = try? Connection("\(defaultPath)/\(databaseName).sqlite3")
            sqliteDataBase.databasePath = "\(defaultPath)/\(databaseName).sqlite3"
        } else {
            
            let default_DataBase_Name = sqliteDataBase.default_DataBase_Name
            sqliteDataBase.databaseName = default_DataBase_Name
            sqliteDataBase.database = try? Connection("\(defaultPath)/\(default_DataBase_Name).sqlite3")
            sqliteDataBase.databasePath = "\(defaultPath)/\(default_DataBase_Name).sqlite3"
        }
    }
    
    // MARK: - 创建表
    public class func createTable(_ tableName: String,object:SQLiteModel) {
        createTable_statement(tableName,object:object)
    }
    
    // MARK: - 插入数据
    public class func insert(object: SQLiteModel, intoTable tableName: String) {
        insert_statement(object,intoTable:tableName)
    }
    
    public class func insertList(objectList: [SQLiteModel], intoTable tableName: String) {
        insertList_statement(objectList,intoTable:tableName)
        
    }
    
    
    // MARK: - 更新数据
    public class func update(_ object: SQLiteModel,fromTable tableName: String) {
        update_statement(object,fromTable:tableName)
    }
    
    public class func updateList(objectList: [SQLiteModel], fromTable tableName: String) {
        updateList_statement(objectList,fromTable:tableName)
    }
    
    // MARK: - 查询数据
    public class func selectAll(fromTable tableName: String)->[[String:AnyObject]]{
        return selectAll_statement(fromTable: tableName)
    }
    
    public class func select(_ object: SQLiteModel,fromTable tableName: String)->[[String:AnyObject]]{
        return select_statement(object,fromTable:tableName)
    }
    
    
    // MARK: - 删除数据
    public class func delete(_ object: SQLiteModel,fromTable tableName: String) {
        delete_statement(object,fromTable:tableName)
    }
    
    
    public class func deleteAll(fromTable tableName: String){
        deleteWhere_statement(fromTable:tableName)
    }
    
    public class func deleteWhere(_ sqlWhere: String,fromTable tableName: String) {
        deleteWhere_statement(sqlWhere,fromTable:tableName)
    }
    
    public class func drop(dropTable tableName: String){
        drop_statement(dropTable:tableName)
    }
    
    
    // MARK: - 示例方法
    /// 创建表
    ///
    /// - Parameters:
    ///   - tableName: 创建的表名
    ///   - mirrorModels:转换完的model
    public func createTable(_ tableName: String,sqlMirrorModel:SQLMirrorModel) {
        createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel)
    }
    
    /// 根据object插入
    ///
    /// - Parameters:
    ///   - object: object
    ///   - tableName: 需要插入的tableName
    public func insert(_ object: SQLiteModel, intoTable tableName: String) {
        insert_statement(object, intoTable: tableName)
    }
    
    /// 根据object修改数据库
    ///
    /// - Parameters:
    ///   - object: 需要修改的object
    ///   - tableName: talbeName
    public func update(_ object: SQLiteModel,fromTable tableName: String) {
        update_statement(object,intoTable: tableName)
    }
    
    
    /// 查询数据
    ///
    /// - Parameters:
    ///   - tableName: 表名
    ///   - sqlWhere: sql查询语句
    /// - Returns: 返回结果
    public func select(fromTable tableName: String,sqlWhere: String? = nil)->[[String:AnyObject]] {
        return select_statement(fromTable:tableName,sqlWhere: sqlWhere)
    }
    
    public func select(_ object: SQLiteModel,fromTable tableName: String)->[[String:AnyObject]] {
        return select_statement(object,fromTable: tableName)
    }
    
    /// 删除table里面的字段
    ///
    /// - Parameters:
    ///   - tableName: table
    ///   - sqlWhere: 执行的where语句
    public func delete(fromTable tableName: String,sqlWhere: String) {
        delete_statement(fromTable:tableName,sqlWhere:sqlWhere)
    }
    
    public func delete(_ object: SQLiteModel,fromTable tableName: String) {
        delete_statement(object,fromTable: tableName)
    }
    
    /// 删除整张表
    ///
    /// - Parameter tableName: 删除的表名
    public func drop(dropTable tableName: String) {
        drop_statement(dropTable:tableName)
    }
    
    // MARK: - 获取默认的路径地址
    public func defaultPath() -> String {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{
            return NSHomeDirectory()
        }
        
        return documentsPath
    }
    
    // MARK: - Tool Func
    // 检查tableName是否有效
    public func checkNameIsVerify(_ name: String) -> Bool {
        if name.count == 0 {
            return false
        }
        
        return true
    }
}

// MARK: - 所有sql执行相关的方法
extension SQLiteDataBase {
    // MARK: - 类方法
    public class func createTable_statement(_ tableName: String,object:SQLiteModel) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        sqliteDataBase.createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel)
    }
    
    public class func insert_statement(_ object: SQLiteModel, intoTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        sqliteDataBase.insert_statement(object, intoTable: tableName)
    }
    
    public class func insertList_statement(_ objectList: [SQLiteModel], intoTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        sqliteDataBase.save_lsit_statement(objectList, intoTable: tableName)
    }
    
    public class func update_statement(_ object: SQLiteModel,fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        sqliteDataBase.update_statement(object,intoTable:tableName)
    }
    
    public class func updateList_statement(_ objectList: [SQLiteModel], fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        sqliteDataBase.update_list_statement(objectList, intoTable: tableName)
    }
    
    public class func selectAll_statement(fromTable tableName: String)->[[String:AnyObject]]{
        let sqliteDataBase = SQLiteDataBase.shared
        
        return sqliteDataBase.select_statement(fromTable:tableName,sqlWhere: nil)
    }
    
    
    public class func select_statement(_ object: SQLiteModel,fromTable tableName: String)->[[String:AnyObject]]{
        let sqliteDataBase = SQLiteDataBase.shared
        
        return sqliteDataBase.select_statement(object,fromTable:tableName)
    }
    
    public class func delete_statement(_ object: SQLiteModel,fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            let key = sqlPropertie.key
            
            guard key == sqlMirrorModel.sqlPrimaryKey else {
                continue
            }
            
            sqliteDataBase.delete_statement(fromTable: tableName,sqlWhere: "\(key) = '\(String(describing: sqlPropertie.value))'")
        }
    }
    
    public class func deleteWhere_statement(_ sqlWhere: String? = nil,fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        sqliteDataBase.delete_statement(fromTable: tableName,sqlWhere: sqlWhere)
    }
    
    public class func drop_statement(dropTable tableName: String){
        let sqliteDataBase = SQLiteDataBase.shared
        sqliteDataBase.drop_statement(dropTable:tableName)
    }
    
    // MARK: - 实例方法
    public func createTable_statement(_ tableName: String,sqlMirrorModel:SQLMirrorModel) {
        
        if !checkNameIsVerify(tableName) {
            return
        }
        
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        if tableExists(tableName: tableFinalName) == true {
            return
        }
        
        
        //创建表
        var sqlStr = "CREATE TABLE IF NOT EXISTS " + tableFinalName
        
        
        //主键
        var primaryKey = ""
        
        //拼接动态字段
        var keyStr = ""
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            
            let key = sqlPropertie.key
            let type = sqlPropertie.type
            let forPrimaryKey = sqlMirrorModel.sqlPrimaryKey
            
            //如果是primaryKey 就返回
            guard key != forPrimaryKey else {
                primaryKey = forPrimaryKey
                continue
            }
            
            keyStr += "\(key) \(SQLiteDataBaseTool.sqlType(type)),"
            
        }
        
        //添加主键
        sqlStr += "(" + primaryKey + " INTEGER UNIQUE PRIMARY KEY NOT NULL,"
        
        sqlStr += SQLiteDataBaseTool.removeLastStr(keyStr)
        
        sqlStr += ")"
        
        execute(sqlStr)
    }
    
    public func isExisit(_ object: SQLiteModel,tableName:String) -> Bool{
        guard database != nil else {
            return false
        }
        
        do {
            //TODO: 主键暂定为Int
            guard let pkidValue = object.value(forKey: object.primaryKey()) as? Int else {
                return false
            }
            
            let sqlStr = "SELECT COUNT(*) FROM \(tableName) where \(object.primaryKey()) = \(String(describing: pkidValue))"
            
            let isExists = try database?.scalar(sqlStr) as! Int64 > 0
            
            return isExists
        }catch {
            return false
        }
    }
    
    public func insert_statement(_ object: SQLiteModel, intoTable tableName: String) {
        save_statement(object,intoTable:tableName)
    }
    
    public func update_statement(_ object: SQLiteModel,intoTable tableName: String) {
        save_statement(object,intoTable:tableName)
    }
    
    public func update_list_statement(_ objects:[SQLiteModel],intoTable tableName: String) {
        save_lsit_statement(objects,intoTable:tableName)
    }
    
    public func save_lsit_statement(_ objects:[SQLiteModel],intoTable tableName: String){
        
        var keyStr   = ""
        var valueSqlStr = ""
        var sqlMirrorModel:SQLMirrorModel?
        
        var list:[[String:NSObject]] = [[String:NSObject]]()
        
        for object in objects{
            sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object)
            
            if(sqlMirrorModel == nil){
                return
            }
            
            createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel!)
            
            var valueStr = ""
            keyStr=""
            
            var keysValues:[String:NSObject]=[String:NSObject]()
            
            for sqlPropertie in sqlMirrorModel!.sqlProperties {
                let key = sqlPropertie.key
                let oldValue = sqlPropertie.value
                
                guard let value = oldValue else {
                    continue
                }
                
                if isExisit(object,tableName:tableName) == true {//存在
                    
                    let primaryKey = sqlMirrorModel!.sqlPrimaryKey
                    
                    keysValues[key]=(value as! NSObject)
                    
                    
                    guard key != primaryKey else {
                        valueStr = "\(key) = '\(value)' ,"
                        continue
                    }
                    
                    // keyStr
                    let tmpStr = "\(key) = '\(value)' ,"
                    
                    keyStr += tmpStr
                }else {//不存在
                    keyStr += (key + " ,")
                    valueStr += ("'\(value)' ,")
                }
            }
            
            if(keysValues.count > 0){
                list.append(keysValues)
            }
            
            
            var sqlStr = ""
            if isExisit(object,tableName:tableName) == true {//存在
                keyStr = SQLiteDataBaseTool.removeLastStr(keyStr)
                valueStr = SQLiteDataBaseTool.removeLastStr(valueStr)
                sqlStr = "UPDATE \(tableName) SET \(keyStr) WHERE \(valueStr)"
                execute(sqlStr)
                
            }else{
                valueSqlStr += "(\(SQLiteDataBaseTool.removeLastStr(valueStr))),"
            }
        }
        
        
        
        
        if(valueSqlStr != ""){
            keyStr = SQLiteDataBaseTool.removeLastStr(keyStr)
            valueSqlStr = SQLiteDataBaseTool.removeLastStr(valueSqlStr)
            
            let sqlStr =  "INSERT INTO \(tableName) (\(keyStr)) VALUES \(valueSqlStr)"
            execute(sqlStr)
        }
        
    }
    
    public func save_statement(_ object: SQLiteModel,intoTable tableName: String) {
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel)
        
        var keyStr   = ""
        var valueStr = ""
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            let key = sqlPropertie.key
            let oldValue = sqlPropertie.value
            
            guard let value = oldValue else {
                continue
            }
            
            if isExisit(object,tableName:tableName) == true {//存在
                
                //                /// 如果字段不存在，则创建
                //                addColumnIfNoExist_statement(key, tableName: tableName, type: SQLiteDataBaseTool.sqlType(sqlPropertie.type))
                
                let primaryKey = sqlMirrorModel.sqlPrimaryKey
                
                guard key != primaryKey else {
                    valueStr = "\(key) = '\(value)' ,"
                    continue
                }
                
                // keyStr
                let tmpStr = "\(key) = '\(value)' ,"
                
                keyStr += tmpStr
            }else {//不存在
                keyStr += (key + " ,")
                valueStr += ("'\(value)' ,")
            }
        }
        
        keyStr = SQLiteDataBaseTool.removeLastStr(keyStr)
        valueStr = SQLiteDataBaseTool.removeLastStr(valueStr)
        
        var sqlStr = ""
        if isExisit(object,tableName:tableName) == true {//存在
            sqlStr = "UPDATE \(tableName) SET \(keyStr) WHERE \(valueStr)"
        }else {//不存在
            sqlStr = "INSERT INTO \(tableName) (\(keyStr)) VALUES (\(valueStr))"
        }
        
        
        execute(sqlStr)
    }
    
    
    public func select_statement(fromTable tableName: String,sqlWhere: String? = nil)->[[String:AnyObject]] {
        if tableExists(tableName: tableName) == false {
            return [[String:AnyObject]]()
        }
        
        var sqlStr = ""
        
        if let sqlWhere = sqlWhere {
            sqlStr = "SELECT * FROM \(tableName) WHERE \(sqlWhere)"
        }else{
            sqlStr = "SELECT * FROM \(tableName)"
        }
        
        let results = prepare(sqlStr)
        
        return results
    }
    
    public func select_statement(_ object: SQLiteModel,fromTable tableName: String)->[[String:AnyObject]] {
        if tableExists(tableName: tableName) == false {
            return [[String:AnyObject]]()
        }
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return [[String:AnyObject]]()
        }
        
        createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel)
        
        var whereStr:String?
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            
            let key = sqlPropertie.key
            
            guard let value = sqlPropertie.value else {
                continue
            }
            
            let primaryKey = sqlMirrorModel.sqlPrimaryKey
            
            guard key != primaryKey else {
                whereStr = "\(key) = '\(String(describing: value))'"
                continue
            }
        }
        
        var sqlStr = ""
        if let whereStr = whereStr {
            sqlStr = "SELECT * FROM \(tableName) WHERE \(whereStr)"
        }else{
            sqlStr = "SELECT * FROM \(tableName)"
        }
        
        let results = prepare(sqlStr)
        
        
        return results
    }
    
    public func delete_statement(fromTable tableName: String,sqlWhere: String?=nil) {
        if tableExists(tableName: tableName) == false {
            return
        }
        
        var sqlStr:String = "DELETE FROM \(tableName)"
        if(sqlWhere != nil){
            sqlStr = "DELETE FROM \(tableName) WHERE \(sqlWhere!)"
        }
        execute(sqlStr)
    }
    
    public func delete_statement(_ object: SQLiteModel,fromTable tableName: String) {
        if tableExists(tableName: tableName) == false {
            return
        }
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        createTable_statement(tableName,sqlMirrorModel:sqlMirrorModel)
        
        var whereStr:String?
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            
            let key = sqlPropertie.key
            let value = sqlPropertie.value
            let primaryKey = sqlMirrorModel.sqlPrimaryKey
            
            if key == primaryKey ,let value = value {
                whereStr = "\(key) = '\(String(describing: value))'"
                continue
            }
        }
        
        if let whereStr = whereStr {
            delete_statement(fromTable: tableName, sqlWhere: whereStr)
        }else{
        }
    }
    
    public func drop_statement(dropTable tableName: String) {
        if tableExists(tableName: tableName) == false {
            return
        }
        
        let sqlStr = "DROP TABLE \(tableName)"
        execute(sqlStr)
    }
    
    //    public func addColumnIfNoExist_statement(_ columnName: String,tableName: String,type:String){
    //       if tableExists(tableName: tableName) == false {
    //            return
    //        }
    //
    //        guard let databaseName = databaseName else {
    //            return
    //        }
    //
    //        guard database != nil else {
    //            return
    //        }
    //
    //        let sqlStr = "select COLUMN_NAME from information_schema.COLUMNS where table_name = ' " + tableName + "' and table_schema = ' " + databaseName + "';"
    //
    //        print("这里")
    //
    //        let oldColumnNames = prepare(sqlStr).map({ (dic:[String : AnyObject]) -> String in
    //            dic.keys.first ?? ""
    //        })
    //
    //        var isExist = false
    //        for oldColumnName in oldColumnNames  {
    //            if columnName == oldColumnName {
    //                isExist = true
    //                break
    //            }
    //        }
    //
    //        print(isExist)
    //
    //        if !isExist {
    //            let alterSqlStr = "ALTER TABLE " + tableName + " ADD \(columnName) \(type)"
    //
    //            execute(alterSqlStr)
    //        }
    //    }
    
    //https://github.com/stephencelis/SQLite.swift/issues/6
    public func tableExists(tableName: String) -> Bool {
        guard database != nil else {
            return false
        }
        
        do {
            let isExists = try database?.scalar(
                "SELECT EXISTS (SELECT * FROM sqlite_master WHERE type = 'table' AND name = ?)", tableName
                ) as! Int64 > 0
            return isExists
        }catch {
            return false
        }
        
    }
    
    
    /// 执行sql语句
    ///
    /// - Parameters:
    ///   - sqrStr: sql语句
    ///   - finish: 结束的闭包
    ///   - fail: 失败的闭包
    public func execute(_ sqlStr:String,finish:()->() = {},fail:()->() = {}){
        do {
            try database?.execute(sqlStr)
            finish()
        }catch {
            fail()
        }
    }
    
    
    /// 查询数据
    ///
    /// - Parameter sqlStr: 查询的语句
    /// - Returns: 返回查询的数据，因为可能是多个，并且每个都以字典类型返回
    /// - 所以是数据类型是[[String:AnyObject]],[String:AnyObject]是字典类型
    public func prepare(_ sqlStr: String)->[[String:AnyObject]]{
        var elements:[[String:AnyObject]] = []
        
        do {
            let results = try database?.prepare(sqlStr)
            if let results = results{
                
                let colunmSize = results.columnNames.count
                
                for row in results  {
                    var record:[String: AnyObject] = [:]
                    
                    for i in 0..<colunmSize {
                        
                        let value   = row[i]
                        let key     = results.columnNames[i] as String
                        
                        if let value = value {
                            record.updateValue(value as AnyObject, forKey: key)
                        }
                        
                    }
                    
                    elements.append(record)
                }
            }
        } catch {
            print(error)
        }
        
        return elements
    }
}


// MARK: - 所有SQLite.swift封装的方法
extension SQLiteDataBase {
    // MARK: - 类方法
    public class func createTable_wrapper(_ tableName: String,object:SQLiteModel) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        sqliteDataBase.createTable_wrapper(tableName,sqlMirrorModel:sqlMirrorModel)
    }
    
    public class func insert_wrapper(_ object: SQLiteModel, intoTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        sqliteDataBase.insert_wrapper(object, intoTable: tableName)
    }
    
    public class func insertList_wrapper(_ objectList: [SQLiteModel], intoTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        for object in objectList {
            sqliteDataBase.insert_wrapper(object, intoTable: tableName)
        }
    }
    
    public class func update_wrapper(_ object: SQLiteModel,fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        sqliteDataBase.update_wrapper(object,intoTable:tableName)
    }
    
    public class func updateList_wrapper(_ objectList: [SQLiteModel], fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        for object in objectList {
            sqliteDataBase.update_wrapper(object,intoTable:tableName)
        }
    }
    
    public class func selectAll_wrapper(fromTable tableName: String)->[[String:AnyObject]]{
        let sqliteDataBase = SQLiteDataBase.shared
        
        return sqliteDataBase.select_wrapper(fromTable:tableName)
    }
    
    public class func select_wrapper(_ object: SQLiteModel,fromTable tableName: String)->[[String:AnyObject]]{
        let sqliteDataBase = SQLiteDataBase.shared
        
        return sqliteDataBase.select_wrapper(object,fromTable:tableName)
    }
    
    public class func delete_wrapper(_ object: SQLiteModel,fromTable tableName: String) {
        let sqliteDataBase = SQLiteDataBase.shared
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            let key = sqlPropertie.key
            
            guard key == sqlMirrorModel.sqlPrimaryKey else {
                continue
            }
            
            sqliteDataBase.delete_wrapper(object, fromTable: tableName)
        }
    }
    
    
    public class func drop_wrapper(dropTable tableName: String){
        let sqliteDataBase = SQLiteDataBase.shared
        sqliteDataBase.drop_wrapper(dropTable:tableName)
    }
    
    // MARK: - 实例方法
    public func createTable_wrapper(_ tableName: String,sqlMirrorModel:SQLMirrorModel) {
        
        if !checkNameIsVerify(tableName) {
            return
        }
        
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        if let _ = dataBaseTables[tableFinalName] {
            return
        }
        
        do {
            let dataBaseTable = Table(tableFinalName)
            
            if let database = database {
                weak var weakSelf = self
                _ = try database.run(dataBaseTable.create(ifNotExists: true, block: { (tableBuilder) in
                    if let strongSelf = weakSelf {
                        for sqlPropertie in sqlMirrorModel.sqlProperties {
                            sqlPropertie.sqlBuildRow(builder: tableBuilder, isPkid: sqlPropertie.isPrimaryKey)
                        }
                        
                        strongSelf.dataBaseTables[tableFinalName] = dataBaseTable
                    }
                }))
            }
        } catch {
        }
    }
    
    public func insert_wrapper(_ object: SQLiteModel, intoTable tableName: String) {
        save_wrapper(object,intoTable:tableName)
    }
    
    public func update_wrapper(_ object: SQLiteModel,intoTable tableName: String) {
        save_wrapper(object,intoTable:tableName)
    }
    
    public func save_wrapper(_ object: SQLiteModel,intoTable tableName: String){
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        
        createTable_wrapper(tableName,sqlMirrorModel:sqlMirrorModel)
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        var sqlSetters:[Setter] = []
        
        var primaryKeyModel:SQLPropertyModel?
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            if sqlPropertie.isPrimaryKey == true {
                primaryKeyModel = sqlPropertie
            }
            
            /// 如果不存在，就添加
            let key = sqlPropertie.key
            addColumnIfNoExist_wrapper(key, fromTable: tableName)
            
            sqlSetters.append(sqlPropertie.sqlSetter(object))
        }
        
        do {
            guard let dataBaseTable:Table = dataBaseTables[tableFinalName],let primaryKeyModel = primaryKeyModel else {
                return
            }
            
            let filterTable = dataBaseTable.filter(primaryKeyModel.sqlFilter(object))
            
            if let _ = try database?.pluck(filterTable) {//如果存在就更新
                _ = try database?.run(filterTable.update(sqlSetters))
            }else {
                _ = try database?.run(dataBaseTable.insert(sqlSetters))
            }
        } catch {
            print(error)
        }
    }
    
    
    
    public func select_wrapper(_ object: SQLiteModel? = nil,fromTable tableName: String)->[[String:AnyObject]] {
        var results = [[String:AnyObject]]()
        
        if tableExists(tableName: tableName) == false {
            return results
        }
        
        guard let object = object else {
            return results
        }
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return results
        }
        
        let modelResults: [SQLiteModel] = select_wrapper_model(object, fromTable: tableName)
        
        //为了保持统一
        for modelResult in modelResults {
            
            // 利用反射取值
            var result = [String:AnyObject]()
            
            let mirror = Mirror(reflecting: modelResult)
            
            guard mirror.displayStyle != nil else {
                continue
            }
            
            guard mirror.children.count > 0 else {
                continue
            }
            
            for sqlPropertie in sqlMirrorModel.sqlProperties {
                
                // 利用反射取值，不使用KVC，因为KVC不支持optional
                var value:Any?
                for child in mirror.children{
                    if sqlPropertie.key == child.label { //注意字典只能保存AnyObject类型。
                        value = sqlPropertie.value
                        break
                    }
                }
                
                if value == nil {
                    value = modelResult.value(forKey: sqlPropertie.key)
                }
                
                result[sqlPropertie.key] = value as AnyObject
            }
            
            results.append(result)
        }
        
        return results
        
    }
    
    public func select_wrapper_model(_ object: SQLiteModel,fromTable tableName: String)->[SQLiteModel] {
        var results = [SQLiteModel]()
        if tableExists(tableName: tableName) == false {
            return results
        }
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return results
        }
        
        
        createTable_wrapper(tableName,sqlMirrorModel:sqlMirrorModel)
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        guard let dataBaseTable:Table = dataBaseTables[tableFinalName] else {
            return results
        }
        
        do {
            guard let datas = try database?.prepare(dataBaseTable) else {
                return results
            }
            
            let classType:SQLiteModel.Type = type(of:object)
            
            for data in datas {
                let sqLiteModel = classType.init()
                for sqlPropertie in sqlMirrorModel.sqlProperties {
                    sqlPropertie.sqlRowToModel(sqLiteModel, row: data)
                }
                
                if  let sqLitePriKey = sqLiteModel.value(forKey: sqLiteModel.primaryKey()) as? String,let objPriKey = object.value(forKey: sqLiteModel.primaryKey()) as? String {
                    //只提取primaryKey一致的数据
                    if sqLitePriKey == objPriKey{
                        results.append(sqLiteModel)
                    }
                }else{
                    results.append(sqLiteModel)
                }
            }
            
            
        } catch {
            print(error)
        }
        
        return results
    }
    
    
    public func delete_wrapper(_ object: SQLiteModel,fromTable tableName: String) {
        if tableExists(tableName: tableName) == false {
            return
        }
        
        guard let sqlMirrorModel = SQLMirrorModel.operateByMirror(object: object) else {
            return
        }
        
        createTable_wrapper(tableName,sqlMirrorModel:sqlMirrorModel)
        
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        var primaryKeyModel:SQLPropertyModel!
        
        for sqlPropertie in sqlMirrorModel.sqlProperties {
            if sqlPropertie.isPrimaryKey == true {
                primaryKeyModel = sqlPropertie
            }
        }
        
        do {
            guard let dataBaseTable:Table = dataBaseTables[tableFinalName],let primaryKeyModel = primaryKeyModel else {
                return
            }
            
            let filterTable = dataBaseTable.filter(primaryKeyModel.sqlFilter(object))
            _ = try database?.run(filterTable.delete())
            
            self.dataBaseTables.removeValue(forKey: tableName)
        } catch {
            print(error)
        }
    }
    
    public func drop_wrapper(dropTable tableName: String) {
        let tableFinalName = SQLiteDataBaseTool.removeBlankSpace(tableName)
        
        guard let dataBaseTable:Table = dataBaseTables[tableFinalName] else {
            return
        }
        
        do {
            _ = try database?.run(dataBaseTable.drop(ifExists: true))
            
            self.dataBaseTables.removeValue(forKey: tableName)
        } catch {
            print(error)
        }
        
    }
    
    public func addColumnIfNoExist_wrapper(_ columnName: String,fromTable tableName: String){
        do {
            if tableExists(tableName: tableName) == false {
                return
            }
            
            let table = Table(tableName)
            
            let expression = table.expression
            guard let oldColumnNames = try database?.prepare(expression.template, expression.bindings).columnNames else{
                return
            }
            
            var isExist = false
            for oldColumnName in oldColumnNames  {
                if columnName == oldColumnName {
                    isExist = true
                    break
                }
            }
            
            if !isExist {
                do {
                    try database?.run(table.addColumn(Expression<String?>(columnName)))
                } catch  {
                    
                }
            }
        } catch {
        }
    }
}
