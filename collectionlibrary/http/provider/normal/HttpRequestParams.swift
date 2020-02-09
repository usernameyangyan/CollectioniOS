//
//  HttpRequestParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

open class HttpRequestParams{
        
    public enum  RequestType{
        case reqStringUrl
        case reqUrlRequest
    }
    
    public enum HttpTypeAndReqParamType{
        case post_json
        case pos_param
        case get
    }
    
    public enum ReponseType {
        case cache
        case netWork
        case noCacheRetrunNetWork
    }
    
    public init(){}
    
    fileprivate var requestUrl:String = ""
    fileprivate var urlRequest: URLRequestConvertible? = nil
    fileprivate var requestType:RequestType  = .reqStringUrl
    fileprivate var params: Parameters = [String:Any]()
    fileprivate var dynamicParams: Parameters = [String:Any]()
    fileprivate var httpTypeAndReqParamType:HttpTypeAndReqParamType = .get
    fileprivate var headers: HTTPHeaders = [String: String]()
    fileprivate var reponseType: ReponseType = .netWork
    
    
    public func setReponseType(responseType:ReponseType)->HttpRequestParams{
        self.reponseType = responseType
        return self
    }
    
    func getReponseType() -> ReponseType {
        return reponseType
    }
    
    
    public func setHttpTypeAndReqParamType(httpTypeAndReqParamType:HttpTypeAndReqParamType)->HttpRequestParams{
        self.httpTypeAndReqParamType=httpTypeAndReqParamType
        return self
    }
    
    func getHttpTypeAndReqParamType() -> HttpTypeAndReqParamType {
        return httpTypeAndReqParamType
    }
    
    public func setReqUrl(requestUrl:String) -> HttpRequestParams {
        self.requestUrl=requestUrl
        return self
    }
    
    func getReqUrl()->String{
        return requestUrl
    }
    
    
    public func setUrlRequest(urlRequest: URLRequestConvertible)->HttpRequestParams{
        self.urlRequest=urlRequest
        return self
    }
    
    func getUrlRequest()->URLRequestConvertible{
        return urlRequest!
    }
    
    
    public func setRequestType(requestType:RequestType)->HttpRequestParams{
        self.requestType=requestType
        return self
    }
    
    func getRequestType() ->RequestType{
        return requestType
    }
    
    public func setParams(params: Parameters)->HttpRequestParams{
        self.params=params
        return self
    }
    
    public func setParam(key:String,param:Any)->HttpRequestParams{
        self.params[key]=param
        return self
    }
    
    
    func getParams() -> Parameters {
        return params
    }
    
    public func setDynamicParams(dynamicParams: Parameters)->HttpRequestParams{
        self.dynamicParams=dynamicParams
        return self
    }
    
    public func setDynamicParam(key:String,param:Any) -> HttpRequestParams {
        self.dynamicParams[key]=param
        return self
    }
    
    func getDyParams() -> Parameters {
        return dynamicParams
    }
    
    public func setHttpHeaders(headers: HTTPHeaders)->HttpRequestParams{
        self.headers=headers
        return self
    }
    
    public func setHttpHeader(key:String,header:String) -> HttpRequestParams {
        self.headers[key]=header
        return self
    }
    
    func getHttpHeaders() -> HTTPHeaders {
        return headers
    }

    
    func build(){
        
        
    }
}
