//
//  HttpRequestParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class HttpRequestParams{
        
    enum  RequestType{
        case reqStringUrl
        case reqUrlRequest
    }
    
    enum HttpTypeAndReqParamType{
        case post_json
        case pos_param
        case get
    }
    
    enum ReponseType {
        case cache
        case netWork
        case noCacheRetrunNetWork
    }
    
    fileprivate var requestUrl:String = ""
    fileprivate var urlRequest: URLRequestConvertible? = nil
    fileprivate var requestType:RequestType  = .reqStringUrl
    fileprivate var params: Parameters = [String:Any]()
    fileprivate var dynamicParams: Parameters = [String:Any]()
    fileprivate var httpTypeAndReqParamType:HttpTypeAndReqParamType = .get
    fileprivate var headers: HTTPHeaders = [String: String]()
    fileprivate var reponseType: ReponseType = .netWork
    
    
    func setReponseType(responseType:ReponseType)->HttpRequestParams{
        self.reponseType = responseType
        return self
    }
    
    func getReponseType() -> ReponseType {
        return reponseType
    }
    
    
    func setHttpTypeAndReqParamType(httpTypeAndReqParamType:HttpTypeAndReqParamType)->HttpRequestParams{
        self.httpTypeAndReqParamType=httpTypeAndReqParamType
        return self
    }
    
    func getHttpTypeAndReqParamType() -> HttpTypeAndReqParamType {
        return httpTypeAndReqParamType
    }
    
    func setReqUrl(requestUrl:String) -> HttpRequestParams {
        self.requestUrl=requestUrl
        return self
    }
    
    func getReqUrl()->String{
        return requestUrl
    }
    
    
    func setUrlRequest(urlRequest: URLRequestConvertible)->HttpRequestParams{
        self.urlRequest=urlRequest
        return self
    }
    
    func getUrlRequest()->URLRequestConvertible{
        return urlRequest!
    }
    
    
    func setRequestType(requestType:RequestType)->HttpRequestParams{
        self.requestType=requestType
        return self
    }
    
    func getRequestType() ->RequestType{
        return requestType
    }
    
    func setParams(params: Parameters)->HttpRequestParams{
        self.params=params
        return self
    }
    
    func setParam(key:String,param:Any)->HttpRequestParams{
        self.params[key]=param
        return self
    }
    
    
    func getParams() -> Parameters {
        return params
    }
    
    func setDynamicParams(dynamicParams: Parameters)->HttpRequestParams{
        self.dynamicParams=dynamicParams
        return self
    }
    
    func setDynamicParam(key:String,param:Any) -> HttpRequestParams {
        self.dynamicParams[key]=param
        return self
    }
    
    func getDyParams() -> Parameters {
        return dynamicParams
    }
    
    func setHttpHeaders(headers: HTTPHeaders)->HttpRequestParams{
        self.headers=headers
        return self
    }
    
    func setHttpHeader(key:String,header:String) -> HttpRequestParams {
        self.headers[key]=header
        return self
    }
    
    func getHttpHeaders() -> HTTPHeaders {
        return headers
    }

    
    func build(){
        
        
    }
}
