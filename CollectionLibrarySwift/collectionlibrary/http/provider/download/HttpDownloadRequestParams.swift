//
//  HttpDownloadRequestParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public class HttpDownloadRequestParams{
    
    enum HttpTypeAndReqParamType{
        case post_json
        case pos_param
        case get
    }
    
    
    fileprivate var requestUrl:String = ""
    fileprivate var method: HTTPMethod = .get
    fileprivate var params: Parameters = [String:Any]()
    fileprivate var dynamicParams: Parameters = [String:Any]()
    fileprivate var httpTypeAndReqParamType:HttpTypeAndReqParamType = .get
    fileprivate var headers: HTTPHeaders = [String: String]()
    fileprivate var fileName:String=""
    
    
    
    func setFileName(fileName:String) -> HttpDownloadRequestParams {
        self.fileName=fileName
        return self
    }
    
    func getFileName() -> String {
        return fileName
    }
    
    
    func setHttpTypeAndReqParamType(httpTypeAndReqParamType:HttpTypeAndReqParamType)->HttpDownloadRequestParams{
        self.httpTypeAndReqParamType=httpTypeAndReqParamType
        return self
    }
    
    func getHttpTypeAndReqParamType() -> HttpTypeAndReqParamType {
        return httpTypeAndReqParamType
    }
    
    func setReqUrl(requestUrl:String) -> HttpDownloadRequestParams {
        self.requestUrl=requestUrl
        return self
    }
    
    func getReqUrl()->String{
        return requestUrl
    }
    
    
    
    func setParams(params: Parameters)->HttpDownloadRequestParams{
        self.params=params
        return self
    }
    
    func setParam(key:String,param:Any)->HttpDownloadRequestParams{
        self.params[key]=param
        return self
    }
    
    
    func getParams() -> Parameters {
        return params
    }
    
    func setDynamicParams(dynamicParams: Parameters)->HttpDownloadRequestParams{
        self.dynamicParams=dynamicParams
        return self
    }
    
    func setDynamicParam(key:String,param:Any) -> HttpDownloadRequestParams {
        self.dynamicParams[key]=param
        return self
    }
    
    func getDyParams() -> Parameters {
        return dynamicParams
    }
    
    func setHttpHeaders(headers: HTTPHeaders)->HttpDownloadRequestParams{
        self.headers=headers
        return self
    }
    
    func setHttpHeader(key:String,header:String) -> HttpDownloadRequestParams {
        self.headers[key]=header
        return self
    }
    
    func getHttpHeaders() -> HTTPHeaders {
        return headers
    }
    
    
    func build(){
    }
}
