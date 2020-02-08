//
//  YYHttpRequestUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


class YYHttpRequestUtils<T:Convertible>{
    
    typealias HttpSuccessResultBlock = ((_ requestSuccessResult:T)->Void)?
    typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
    
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
        
        if(YYHttpGlobalSetting.showHttpRequestLog){
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


extension YYHttpRequestUtils{
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

