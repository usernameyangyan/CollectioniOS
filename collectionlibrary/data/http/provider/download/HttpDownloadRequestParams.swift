//
//  HttpDownloadRequestParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public class HttpDownloadRequestParams{
    
    public enum HttpTypeAndReqParamType{
        case post_json
        case pos_param
        case get
    }
    
    public init(){}
    
    
    fileprivate var requestUrl:String = ""
    fileprivate var method: HTTPMethod = .get
    fileprivate var params: Parameters = [String:Any]()
    fileprivate var dynamicParams: Parameters = [String:Any]()
    fileprivate var httpTypeAndReqParamType:HttpTypeAndReqParamType = .get
    fileprivate var headers: HTTPHeaders = [String: String]()
    fileprivate var fileName:String=""
    
    
    
    public func setFileName(fileName:String) -> HttpDownloadRequestParams {
        self.fileName=fileName
        return self
    }
    
    func getFileName() -> String {
        return fileName
    }
    
    
    public func setHttpTypeAndReqParamType(httpTypeAndReqParamType:HttpTypeAndReqParamType)->HttpDownloadRequestParams{
        self.httpTypeAndReqParamType=httpTypeAndReqParamType
        return self
    }
    
    func getHttpTypeAndReqParamType() -> HttpTypeAndReqParamType {
        return httpTypeAndReqParamType
    }
    
    public func setReqUrl(requestUrl:String) -> HttpDownloadRequestParams {
        self.requestUrl=requestUrl
        return self
    }
    
    func getReqUrl()->String{
        return requestUrl
    }
    
    
    
    public func setParams(params: Parameters)->HttpDownloadRequestParams{
        self.params=params
        return self
    }
    
    public func setParam(key:String,param:Any)->HttpDownloadRequestParams{
        self.params[key]=param
        return self
    }
    
    
    func getParams() -> Parameters {
        return params
    }
    
    public func setDynamicParams(dynamicParams: Parameters)->HttpDownloadRequestParams{
        self.dynamicParams=dynamicParams
        return self
    }
    
    public func setDynamicParam(key:String,param:Any) -> HttpDownloadRequestParams {
        self.dynamicParams[key]=param
        return self
    }
    
    func getDyParams() -> Parameters {
        return dynamicParams
    }
    
    public func setHttpHeaders(headers: HTTPHeaders)->HttpDownloadRequestParams{
        self.headers=headers
        return self
    }
    
    public func setHttpHeader(key:String,header:String) -> HttpDownloadRequestParams {
        self.headers[key]=header
        return self
    }
    
    func getHttpHeaders() -> HTTPHeaders {
        return headers
    }
    
    
    public func build(){
    }
}
