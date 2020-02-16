//
//  DataManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/12.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

open class DataManager{
    
    
    
    public class DataForUserDefaults<T>{
        
        public static func saveObjectForKey<T>(key:String,object:T){
            
            if(T.self is Convertible.Type){
                UserDefaults.standard.set((object as! Convertible).yy_JSONString(), forKey: key)
            } else{
                UserDefaults.standard.set(object, forKey: key)
            }
        }
        
        
        public static func  queryObjectForKey(key:String)->DataResult<T>{
            
            let result=DataResult<T>()
            
            if(T.self is Int.Type){
                result.result=(UserDefaults.standard.integer(forKey: key) as! T)
                return  result
            }else if(T.self is String.Type){
                if(UserDefaults.standard.string(forKey: key) != nil){
                    result.result=(UserDefaults.standard.string(forKey: key) as! T)
                }
                return  result
            }else if(T.self is Array<Any>.Type || T.self is Array<String>.Type || T.self is Array<Float>.Type || T.self is Array<Double>.Type || T.self is Array<Bool>.Type){
                if(UserDefaults.standard.array(forKey: key) != nil){
                    result.result=(UserDefaults.standard.array(forKey: key) as! T)
                    return  result
                }
                
            }else if(T.self is Float.Type){
                result.result=(UserDefaults.standard.float(forKey: key) as! T)
                return  result
            }else if(T.self is Data.Type){
                if(UserDefaults.standard.data(forKey: key) != nil){
                    result.result=(UserDefaults.standard.data(forKey: key) as! T)
                    return  result
                }
                
            }else if(T.self is Double.Type){
                result.result=(UserDefaults.standard.double(forKey: key) as! T)
                return  result
            }else if(T.self is URL.Type){
                if(UserDefaults.standard.url(forKey: key) != nil){
                    result.result=(UserDefaults.standard.url(forKey: key) as! T)
                    return result
                }
            }else if(T.self is Bool.Type){
                result.result=(UserDefaults.standard.bool(forKey: key) as! T)
                return  result
            }else if(T.self is Dictionary<String, Any>.Type || T.self is Dictionary<String, String>.Type || T.self is Dictionary<String, Bool>.Type || T.self is Dictionary<String, Float>.Type || T.self is Dictionary<String, Double>.Type){
                if(UserDefaults.standard.dictionary(forKey: key) != nil){
                    result.result=(UserDefaults.standard.dictionary(forKey: key) as! T)
                    return result
                }
            }else if(T.self is Convertible.Type){
                
                if(UserDefaults.standard.string(forKey: key) != nil){
                    result.result=(UserDefaults.standard.string(forKey: key)!.yy.model(type: T.self as! Convertible.Type) as! T)
                    return  result
                }
                
            }
            
            return result
        }
    }
    
    
    
    public class DataForFile<T>{
        
        
        
        public static func saveObjectForFile<U>(appendFolderPathAndFileName:String,object:U){
            
            if(T.self is Convertible.Type){
                FileOperationUtils.writeToFileAtPath(appendFolderPathAndFileName: appendFolderPathAndFileName, withString: (object as! Convertible).yy_JSONString())
            } else{
                FileOperationUtils.writeToFileAtPath(appendFolderPathAndFileName: appendFolderPathAndFileName, withString: object as! T as! String)
            }
        }
        
        
        
        public static func  queryObjectForFile(appendFolderPathAndFileName:String)->DataResult<T>{
            
            let result=DataResult<T>()
            
            if(T.self is Convertible.Type){
                
                let json=FileOperationUtils.readFileAtPath(appendFolderPathAndFileName:appendFolderPathAndFileName)
                
                if(json != ""){
                    result.result=(json.yy.model(type: T.self as! Convertible.Type) as! T)
                }
                
            }else{
                result.result=(FileOperationUtils.readFileAtPath(appendFolderPathAndFileName: appendFolderPathAndFileName) as! T)
            }
            
            return result
        }
        
    }
    
    
    
    public class DataForSQLiteDB{
        
        public class QueryData<T:Convertible>{
            
            public typealias QueryArraySuccessResultBlock = ((_ queryArraySuccessResult:Array<T>)->Void)?
            public typealias QueryFailResultBlock = (()->Void)?
            
            public static func queryAllData()->DataResult<Array<T>>{
                
                let result=DataResult<Array<T>>()
                
                let spilts=NSStringFromClass(T.self as! AnyClass).split(separator: ".")
                let results=SQLiteDataBase.selectAll(fromTable: String(spilts[spilts.count-1]))
                
                
                
                if(results.count>0){
                    result.result=modelArray(from: results, T.self)
                }
                
                return result
            }
            
            
            
            public static func queryAllDataByAsnyc(queryArraySuccessResult:QueryArraySuccessResultBlock,queryFailResultBlock:QueryFailResultBlock){
                
                var queryResult:Array<T>?
                var  results:[[String:AnyObject]]?
                Async.background{
                    let spilts=NSStringFromClass(T.self as! AnyClass).split(separator: ".")
                    results=SQLiteDataBase.selectAll(fromTable: String(spilts[spilts.count-1]))
                    
                    if(results != nil && results!.count>0){
                        queryResult=modelArray(from: results!, T.self)
                    }
                    
                }.main{
                    if(results != nil && results!.count>0){
                        queryArraySuccessResult!(queryResult!)
                    }else{
                        queryFailResultBlock!()
                    }
                }
            }
            
            
            public static func queryDataByWhere(sqlWhere:String)->DataResult<Array<T>>{
                let spilts=NSStringFromClass(T.self as! AnyClass).split(separator: ".")
                let result=DataResult<Array<T>>()
                let results=SQLiteDataBase.shared.select(fromTable: String(spilts[spilts.count-1]), sqlWhere: sqlWhere)
                
                if(results.count>0){
                    result.result=modelArray(from: results, T.self)
                }
                
                return result
                
            }
            
            
            public static func queryDataWithWhereByAsync(sqlWhere:String,queryArraySuccessResult:QueryArraySuccessResultBlock,queryFailResultBlock:QueryFailResultBlock){
                
                var queryResult:Array<T>?
                var  results:[[String:AnyObject]]?
                Async.background{
                    let spilts=NSStringFromClass(T.self as! AnyClass).split(separator: ".")
                    
                    results=SQLiteDataBase.shared.select(fromTable: String(spilts[spilts.count-1]), sqlWhere: sqlWhere)
                    if(results != nil && results!.count>0){
                        queryResult=modelArray(from: results!, T.self)
                    }
                }.main{
                    
                    if(results != nil && results!.count>0){
                        queryArraySuccessResult!(queryResult!)
                    }else{
                        queryFailResultBlock!()
                    }
                    
                }
                
            }
            
            public static func queryDataByFirst()->DataResult<T>{
                let result=DataResult<T>()
                let spilts=NSStringFromClass(T.self as! AnyClass).split(separator: ".")
                
                let results=SQLiteDataBase.selectAll(fromTable: String(spilts[spilts.count-1]))
                if(results.count>0){
                    let list=modelArray(from: results, T.self)
                    result.result=list[0]
                }
                
                return result
            }
            
        }
        
        public class Share{
            public typealias InsertCompleteBlock = (()->Void)?
            public static func insertData(object: SQLiteModel){
                let spilts=NSStringFromClass(object.classForCoder).split(separator: ".")
                SQLiteDataBase.shared.insert(object, intoTable: String(spilts[spilts.count-1]))
            }
            
            
            public static func insertDataList(cls:AnyClass,objectList:[SQLiteModel]){
                let spilts=NSStringFromClass(cls).split(separator: ".")
                SQLiteDataBase.insertList(objectList: objectList, intoTable: String(spilts[spilts.count-1]))
            }
            
            public static func insertDataListByAsync(cls:AnyClass,objectList:[SQLiteModel],insertCompleteBlock:InsertCompleteBlock){
                
                Async.background{
                    let spilts=NSStringFromClass(cls).split(separator: ".")
                    SQLiteDataBase.insertList(objectList: objectList, intoTable: String(spilts[spilts.count-1]))
                }.main{
                    insertCompleteBlock!()
                }
            }
            
            
            public static func deleteDataByWhere(cls:AnyClass,sqlWhere:String){
                let spilts=NSStringFromClass(cls).split(separator: ".")
                SQLiteDataBase.deleteWhere(sqlWhere, fromTable: String(spilts[spilts.count-1]))
            }
            
            public static func deleteDataWithWhereByAsync(cls:AnyClass,sqlWhere:String,insertCompleteBlock:InsertCompleteBlock){
                
                Async.background{
                    let spilts=NSStringFromClass(cls).split(separator: ".")
                    SQLiteDataBase.deleteWhere(sqlWhere, fromTable: String(spilts[spilts.count-1]))
                }.main{
                    insertCompleteBlock!()
                }
            }
            
            public static func deleteAllData(cls:AnyClass){
                let spilts=NSStringFromClass(cls).split(separator: ".")
                SQLiteDataBase.deleteAll(fromTable: String(spilts[spilts.count-1]))
            }
            
            public static func deleteAllDataByAsync(cls:AnyClass,insertCompleteBlock:InsertCompleteBlock){
                
                Async.background{
                    let spilts=NSStringFromClass(cls).split(separator: ".")
                    SQLiteDataBase.deleteAll(fromTable: String(spilts[spilts.count-1]))
                }.main{
                    insertCompleteBlock!()
                }
            }
            
            
            public static func updateData(object:SQLiteModel){
                let spilts=NSStringFromClass(object.classForCoder).split(separator: ".")
                SQLiteDataBase.update(object, fromTable: String(spilts[spilts.count-1]))
            }
            
            public static func updateDataList(cls:AnyClass,objectList:[SQLiteModel]){
                let spilts=NSStringFromClass(cls).split(separator: ".")
                SQLiteDataBase.updateList(objectList: objectList, fromTable: String(spilts[spilts.count-1]))
            }
            
            public static func updateDataListByAsync(cls:AnyClass,objectList:[SQLiteModel],insertCompleteBlock:InsertCompleteBlock){
                
                Async.background{
                    let spilts=NSStringFromClass(cls).split(separator: ".")
                    SQLiteDataBase.updateList(objectList: objectList, fromTable: String(spilts[spilts.count-1]))
                    
                }.main{
                    insertCompleteBlock!()
                }
            }
            
            
            public static func drop(cls:AnyClass){
                let spilts=NSStringFromClass(cls).split(separator: ".")
                SQLiteDataBase.drop(dropTable: String(spilts[spilts.count-1]))
            }
        }
        
    }
    
    
    public class DataForHttp{
        public class GlobalSetting{
            public  static var showHttpRequestLog:Bool=false
            
            /**==============================设置全区参数==============================================**/
            /// 缓存过期时间
            ///
            /// - Parameter expiry: 参考 DaisyExpiry
            public static func cacheTimeOutWithClear(expiry: YYHttpExpiry) {
                YYHttpCacheManager.default.expiryConfiguration(expiry: expiry)
            }
            
            /// 超时时间
            ///
            /// - Parameter timeInterval: 超时时间
            public static func timeoutIntervalForRequest(_ timeInterval :TimeInterval) {
                YYHttpRequestManager.default.timeoutIntervalForRequest(timeInterval)
            }
        }
        
        
        public class HttpOfNormal{
            
            public class Request<T:Convertible>{
                public typealias HttpSuccessResultBlock = ((_ requestSuccessResult:T)->Void)?
                public typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
                
                /**=============================网络请求===============================================**/
                public static func request(httpRequestParams:HttpRequestParams,requestSuccessResult:HttpSuccessResultBlock,requestFailureResult:HttpFailureResultBlock){
                    
                    let url=httpRequestParams.getReqUrl()
                    var method: HTTPMethod = .get
                    var encoding: ParameterEncoding = URLEncoding.default
                    if(httpRequestParams.getHttpTypeAndReqParamType() == .pos_param){
                        method = .post
                    }else if(httpRequestParams.getHttpTypeAndReqParamType() == .post_json){
                        method = .post
                        encoding = JSONEncoding.default
                    }
                    
                    var isCache:Bool=false
                    
                    if(httpRequestParams.getReponseType() == .cache||httpRequestParams.getReponseType() == .noCacheRetrunNetWork){
                        isCache=true
                    }
                    
                    if(httpRequestParams.getRequestType() == .reqStringUrl && httpRequestParams.getReqUrl() == ""){
                        Logger.error("缺失请求Url")
                        return
                    }
                    
                    if(DataManager.DataForHttp.GlobalSetting.showHttpRequestLog){
                        Logger.info("请求参数:")
                        if(httpRequestParams.getHttpTypeAndReqParamType() == .post_json){
                            Logger.info(ParamsSerializationJsonTool.paramsSerializationJson(param: httpRequestParams.getParams()))
                        }else{
                            Logger.info(httpRequestParams.getParams())
                        }
                        
                    }
                    
                    
                    
                    let httpRequestTaskManager=YYHttpRequestManager.default.request(url, method: method, params: httpRequestParams.getParams(), dynamicParams: httpRequestParams.getDyParams(), encoding: encoding, headers: httpRequestParams.getHttpHeaders()).cache(isCache)
                    
                    if(httpRequestParams.getReponseType() == .cache){
                        httpRequestTaskManager.cacheString(completion: {
                            value in
                            if(value == ""){
                                requestFailureResult!("暂无缓存数据")
                            }else{
                                let result = model(from: value, T.self)
                                requestSuccessResult!(result!)
                            }
                            
                        })
                    }else if(httpRequestParams.getReponseType() == .noCacheRetrunNetWork){
                        httpRequestTaskManager.responseCacheOrString(completion: {
                            value in
                            switch(value.result){
                            case .success(let re):
                                let result = model(from: re, T.self)
                                
                                if(result != nil){
                                    requestSuccessResult!(result!)
                                }else{
                                    requestFailureResult!("数据请求失败")
                                }
                            case .failure(let error):
                                requestFailureResult!(error.localizedDescription)
                            }
                        })
                    }else{
                        httpRequestTaskManager.responseString(completion: {
                            value in
                            switch(value.result){
                            case .success(let re):
                                let result = model(from: re, T.self)
                                if(result != nil){
                                    requestSuccessResult!(result!)
                                }else{
                                    requestFailureResult!("数据请求失败")
                                }
                            case .failure(let error):
                                requestFailureResult!(error.localizedDescription)
                            }
                        })
                    }
                    
                }
            }
            
            public class Share{
                // 取消请求
                ///
                /// - Parameters:
                ///   - url: url
                ///   - params: 参数
                ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
                public static func cancel(httpRequestParams:HttpRequestParams) {
                    YYHttpRequestManager.default.cancel(httpRequestParams.getReqUrl(), params: httpRequestParams.getParams(), dynamicParams: httpRequestParams.getDyParams())
                }
                
                
                /// 清除所有缓存
                ///
                /// - Parameter completion: 完成回调
                public static func removeAllCache(completion: @escaping (Bool)->()) {
                    YYHttpRequestManager.default.removeAllCache(completion: completion)
                }
                
                
                /// 根据url和params清除缓存
                ///
                /// - Parameters:
                ///   - url: url
                ///   - params: 参数
                ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
                ///   - completion: 完成回调
                public static func removeObjectCache(httpRequestParams:HttpRequestParams, completion: @escaping (Bool)->()) {
                    YYHttpRequestManager.default.removeObjectCache(httpRequestParams.getReqUrl(), params: httpRequestParams.getParams(),dynamicParams: httpRequestParams.getDyParams(), completion: completion)
                }
            }
            
        }
        
        public class HttpOfUpload{
            
            public class Upload<T:Convertible>{
                public typealias HttpSuccessResultBlock = ((_ requestSuccessResult:T)->Void)?
                public typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
                public typealias HttpProgressResultBlock = ((_ requestProgress:Double)->Void)?
                
                public static func upload(httpRequestParams:HttpUploadRequestParams,requestSuccessResult:HttpSuccessResultBlock,requestFailureResult:HttpFailureResultBlock,requestProgress:HttpProgressResultBlock){
                    
                    
                    let url=httpRequestParams.getReqUrl()
                    let multipartName = httpRequestParams.getMultiparName()
                    
                    if(httpRequestParams.getReqUrl() == ""){
                        Logger.error("缺失请求Url")
                        return
                    }
                    
                    if(DataManager.DataForHttp.GlobalSetting.showHttpRequestLog){
                        Logger.info("请求参数:")
                        Logger.info(httpRequestParams.getParams())
                        
                    }
                    
                    var suffixName=".png"
                    
                    if(httpRequestParams.getFileSuffixName() != ""){
                        suffixName=httpRequestParams.getFileSuffixName()
                    }
                    
                    YYHttpUploadManager.default.upload(urlString: url, multipartName:multipartName,params: httpRequestParams.getParams(),headers: httpRequestParams.getHttpHeaders() ,images: httpRequestParams.getImages(),suffixName:suffixName , success: {
                        result in
                        
                        if(result == ""){
                            requestFailureResult!("上传失败")
                        }else{
                            let result = model(from: result!, T.self)
                            requestSuccessResult!(result!)
                        }
                        
                    }, failture: { error in
                        requestFailureResult!(error.localizedDescription)
                        
                    }, progress: { progress in
                        requestProgress!(progress)
                    }).build()
                    
                }
            }
            
        }
        
        public class HttpOfDownload{
            public class Download{
                public typealias HttpSuccessResultBlock = ((_ requestSuccessResult:String)->Void)?
                public typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
                public typealias HttpDownloadProgressBlock = ((_ downloadProgress:Double)->Void)?
                public typealias HttpDownloadResumeBlock = (()->Void)?
                
                
                public static func download(httpDownloadRequestParams:HttpDownloadRequestParams,requestSuccessResult:HttpSuccessResultBlock,requestFailureResult:HttpFailureResultBlock,downloadProgress:HttpDownloadProgressBlock){
                    let url=httpDownloadRequestParams.getReqUrl()
                    var method: HTTPMethod = .get
                    var encoding: ParameterEncoding = URLEncoding.default
                    if(httpDownloadRequestParams.getHttpTypeAndReqParamType() == .pos_param){
                        method = .post
                    }else if(httpDownloadRequestParams.getHttpTypeAndReqParamType() == .post_json){
                        method = .post
                        encoding = JSONEncoding.default
                    }
                    
                    
                    if(httpDownloadRequestParams.getReqUrl() == ""){
                        Logger.error("缺失请求Url")
                        return
                    }
                    
                    if(httpDownloadRequestParams.getFileName() == ""){
                        Logger.error("缺失FileName")
                        return
                    }
                    
                    
                    
                    if(DataManager.DataForHttp.GlobalSetting.showHttpRequestLog){
                        Logger.info("请求参数:")
                        if(httpDownloadRequestParams.getHttpTypeAndReqParamType() == .post_json){
                            Logger.info(ParamsSerializationJsonTool.paramsSerializationJson(param: httpDownloadRequestParams.getParams()))
                        }else{
                            Logger.info(httpDownloadRequestParams.getParams())
                        }
                        
                    }
                    
                    
                    YYHttpDownloadManager.default.download(url,method: method,parameters: httpDownloadRequestParams.getParams(),dynamicParams: httpDownloadRequestParams.getDyParams(),encoding: encoding,headers: httpDownloadRequestParams.getHttpHeaders(),fileName: httpDownloadRequestParams.getFileName())
                        .downloadProgress(progress: {
                            prossgress in
                            downloadProgress!(prossgress)
                        }).response(completion: {
                            value in
                            switch(value){
                            case .success(let re):
                                requestSuccessResult!(re)
                            case .failure(let error):
                                requestFailureResult!(error.localizedDescription)
                            }
                        })
                    
                }
                
                
                public static func resume(url:String,downloadResume:HttpDownloadResumeBlock){
                    downloadProgress(url, progress: {
                        progress in
                        downloadResume!()
                    })?.response(completion: {
                        value in
                        downloadResume!()
                    })
                }
                
                /// 取消下载
                ///
                /// - Parameter url: url
                public static func downloadCancel(_ url: String, parameters: Parameters? = nil, dynamicParams: Parameters? = nil) {
                    YYHttpDownloadManager.default.cancel(url, parameters: parameters, dynamicParams: dynamicParams)
                }
                
                /// Cancel all download tasks
                public static func downloadCancelAll() {
                    YYHttpDownloadManager.default.cancelAll();
                }
                
                /// 下载百分比
                ///
                /// - Parameter url: url
                /// - Returns: percent
                public static func downloadPercent(_ url: String, parameters: Parameters? = nil, dynamicParams: Parameters? = nil) -> Double {
                    return YYHttpDownloadManager.default.downloadPercent(url, parameters: parameters, dynamicParams: dynamicParams)
                }
                
                /// 删除某个下载
                ///
                /// - Parameters:
                ///   - url: url
                ///   - completion: download success/failure
                public static func downloadDelete(_ url: String, parameters: Parameters? = nil,dynamicParams: Parameters? = nil, completion: @escaping (Bool)->()) {
                    YYHttpDownloadManager.default.delete(url,parameters: parameters,dynamicParams: dynamicParams, completion: completion)
                }
                
                /// 下载状态
                ///
                /// - Parameter url: url
                /// - Returns: status
                public static func downloadStatus(_ url: String, parameters: Parameters? = nil,dynamicParams: Parameters? = nil) -> DownloadStatus {
                    return YYHttpDownloadManager.default.downloadStatus(url, parameters: parameters,dynamicParams: dynamicParams)
                }
                
                /// 下载完成后，文件所在位置
                ///
                /// - Parameter url: url
                /// - Returns: file URL
                public static func downloadFilePath(_ url: String, parameters: Parameters? = nil,dynamicParams: Parameters? = nil) -> URL? {
                    return YYHttpDownloadManager.default.downloadFilePath(url, parameters: parameters,dynamicParams: dynamicParams)
                }
                
                /// 下载中的进度,任务下载中时，退出当前页面,再次进入时继续下载
                ///
                /// - Parameters:
                ///   - url: url
                ///   - progress: 进度
                /// - Returns: taskManager
                private static func downloadProgress(_ url: String, parameters: Parameters? = nil,dynamicParams: Parameters? = nil, progress: @escaping ((Double)->())) -> YYHttpDownloadTaskManager? {
                    return YYHttpDownloadManager.default.downloadProgress(url, parameters: parameters,dynamicParams: dynamicParams, progress: progress)
                }
            }
        }
        
    }
    
}
