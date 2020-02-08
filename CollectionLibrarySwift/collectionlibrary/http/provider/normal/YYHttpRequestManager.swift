//
//  YYHttpRequestManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class YYHttpRequestManager {
    
    static let `default` = YYHttpRequestManager()
    private var requestTasks = [String: YYHttpRequestTaskManager]()
    private var timeoutIntervalForRequest: TimeInterval? /// 超时时间
    
    func timeoutIntervalForRequest(_ timeInterval :TimeInterval) {
        self.timeoutIntervalForRequest = timeInterval
        YYHttpRequestManager.default.timeoutIntervalForRequest = timeoutIntervalForRequest
    }
    
    func request(
        _ url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        dynamicParams: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> YYHttpRequestTaskManager
    {
        let key = cacheKey(url, params, dynamicParams)
        var taskManager : YYHttpRequestTaskManager?
        if requestTasks[key] == nil {
            if timeoutIntervalForRequest != nil {
                taskManager = YYHttpRequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
            } else {
                taskManager = YYHttpRequestTaskManager()
            }
            requestTasks[key] = taskManager
        } else {
            taskManager = requestTasks[key]
        }
        
        taskManager?.completionClosure = {
            self.requestTasks.removeValue(forKey: key)
        }
        var tempParam = params==nil ? [:] : params!
        let dynamicTempParam = dynamicParams==nil ? [:] : dynamicParams!
        dynamicTempParam.forEach { (arg) in
            tempParam[arg.key] = arg.value
        }
        taskManager?.request(url, method: method, params: tempParam, cacheKey: key, encoding: encoding, headers: headers)
        return taskManager!
    }
    
    func request(
        urlRequest: URLRequestConvertible,
        params: Parameters,
        dynamicParams: Parameters? = nil)
        -> YYHttpRequestTaskManager? {
            if let urlStr = urlRequest.urlRequest?.url?.absoluteString {
                let components = urlStr.components(separatedBy: "?")
                if components.count > 0 {
                    let key = cacheKey(components.first!, params, dynamicParams)
                    var taskManager : YYHttpRequestTaskManager?
                    if requestTasks[key] == nil {
                        if timeoutIntervalForRequest != nil {
                            taskManager = YYHttpRequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
                        } else {
                            taskManager = YYHttpRequestTaskManager()
                        }
                        requestTasks[key] = taskManager
                    } else {
                        taskManager = requestTasks[key]
                    }
                    
                    taskManager?.completionClosure = {
                        self.requestTasks.removeValue(forKey: key)
                    }
                    var tempParam = params
                    let dynamicTempParam = dynamicParams==nil ? [:] : dynamicParams!
                    dynamicTempParam.forEach { (arg) in
                        tempParam[arg.key] = arg.value
                    }
                    taskManager?.request(urlRequest: urlRequest, cacheKey: key)
                    return taskManager!
                }
                return nil
            }
            return nil
    }
    
    /// 取消请求
    func cancel(_ url: String, params: Parameters? = nil, dynamicParams: Parameters? = nil) {
        let key = cacheKey(url, params, dynamicParams)
        let taskManager = requestTasks[key]
        taskManager?.dataRequest?.cancel()
    }
    
    
    /// 清除所有缓存
    func removeAllCache(completion: @escaping (Bool)->()) {
        YYHttpCacheManager.default.removeAllCache(completion: completion)
    }
    
    /// 根据key值清除缓存
    func removeObjectCache(_ url: String, params: [String: Any]? = nil, dynamicParams: Parameters? = nil,  completion: @escaping (Bool)->()) {
        let key = cacheKey(url, params, dynamicParams)
        YYHttpCacheManager.default.removeObjectCache(key, completion: completion)
    }
    
}

// MARK: - 请求任务
public class YYHttpRequestTaskManager {
    fileprivate var dataRequest: DataRequest?
    fileprivate var cache: Bool = false
    fileprivate var cacheKey: String!
    fileprivate var sessionManager: SessionManager?
    fileprivate var completionClosure: (()->())?
    
    @discardableResult
    fileprivate func timeoutIntervalForRequest(_ timeInterval :TimeInterval) -> YYHttpRequestTaskManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeInterval
        let sessionManager = SessionManager(configuration: configuration)
        self.sessionManager = sessionManager
        return self
    }
    
    @discardableResult
    fileprivate func request(
        _ url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        cacheKey: String,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> YYHttpRequestTaskManager
    {
        self.cacheKey = cacheKey
        if sessionManager != nil {
            dataRequest = sessionManager?.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        } else {
            dataRequest = CollectionLibrarySwift.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        }
        
        return self
    }
    
    
    /// request
    ///
    /// - Parameters:
    ///   - urlRequest: urlRequest
    ///   - cacheKey: cacheKey
    /// - Returns: YYHttpRequestTaskManager
    @discardableResult
    fileprivate func request(
        urlRequest: URLRequestConvertible,
        cacheKey: String)
        -> YYHttpRequestTaskManager {
            self.cacheKey = cacheKey
            if sessionManager != nil {
                dataRequest = sessionManager?.request(urlRequest)
            } else {
                dataRequest = CollectionLibrarySwift.request(urlRequest)
            }
            return self
    }

    
    /// 是否缓存数据
    public func cache(_ cache: Bool) -> YYHttpRequestTaskManager {
        self.cache = cache
        return self
    }
    
    
    public func responseString(completion: @escaping (YYHttpValue<String>)->()) {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseString(completion: completion)
    }
    
    
    /// 获取缓存String
    @discardableResult
    public func cacheString(completion: @escaping (String)->()) -> DaisyStringResponse {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return stringResponse.cacheString(completion:completion)
    }
    
    //如果有缓存就返回缓存，没有缓存就返回网络数据
    public func responseCacheOrString(completion: @escaping (YYHttpValue<String>)->()) {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseCacheOrString(completion: completion)
    }
}
// MARK: - DaisyBaseResponse
public class DaisyResponse {
    fileprivate var dataRequest: DataRequest
    fileprivate var cache: Bool
    fileprivate var cacheKey: String
    fileprivate var completionClosure: (()->())?
    fileprivate init(dataRequest: DataRequest, cache: Bool, cacheKey: String, completionClosure: (()->())?) {
        self.dataRequest = dataRequest
        self.cache = cache
        self.cacheKey = cacheKey
        self.completionClosure = completionClosure
    }
    ///
    fileprivate func response<T>(response: DataResponse<T>, completion: @escaping (YYHttpValue<T>)->()) {
        responseCache(response: response) { (result) in
            completion(result)
        }
    }
    /// isCacheData
    fileprivate func responseCache<T>(response: DataResponse<T>, completion: @escaping (YYHttpValue<T>)->()) {
        if completionClosure != nil { completionClosure!() }
        let result = YYHttpValue(isCacheData: false, result: response.result, response: response.response)
        if(YYHttpGlobalSetting.showHttpRequestLog){
            Logger.info("============开始获取数据===============")
            Logger.info("\n"+"请求Url:"+(response.request?.url!.absoluteString)! )
            
        }
        
        switch response.result {
        case .success(_):
            
            if(YYHttpGlobalSetting.showHttpRequestLog){
                if let data = response.data,
                    let str = String(data: data, encoding: .utf8) {
                    Logger.info("网路请求结果:\n"+str )
                }
                
            }
            
            if self.cache {/// 写入缓存
                var model = YYHttpCacheModel()
                model.data = response.data
                YYHttpCacheManager.default.setObject(model, forKey: self.cacheKey,expiry:YYHttpCacheManager.default.expiry.expiry)
            }
        case .failure(let error):
            if(YYHttpGlobalSetting.showHttpRequestLog){
                Logger.info("\n"+error.localizedDescription)
            }
        }
        completion(result)
    }
}

// MARK: - DaisyStringResponse
public class DaisyStringResponse: DaisyResponse {
    /// 响应String
    func responseString(completion: @escaping (YYHttpValue<String>)->()) {
        dataRequest.responseString(completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    @discardableResult
    fileprivate func cacheString(completion: @escaping (String)->()) -> DaisyStringResponse {
        if let data = YYHttpCacheManager.default.objectSync(forKey: cacheKey)?.data,
            let str = String(data: data, encoding: .utf8) {
            completion(str)
            if(YYHttpGlobalSetting.showHttpRequestLog){
                Logger.info("获取缓存数据：\n"+str)
            }
        } else {
            completion("")
        }
        return self
    }
    
    fileprivate func responseCacheOrString(completion: @escaping (YYHttpValue<String>)->()) {
        if cache { cacheString(completion: { str in
            if(str != ""){
                let res = YYHttpValue(isCacheData: true, result: HttpBaseResult.success(str), response: nil)
                completion(res)
            }else{
                self.dataRequest.responseString { (response) in
                    self.responseCache(response: response, completion: completion)
                }
                
            }
        })}
    }
}
