//
//  HttpUploadRequestParams.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public class HttpUploadRequestParams{
    
    fileprivate var requestUrl:String = ""
    fileprivate var params: [String:String] = [String:String]()
    fileprivate var headers: HTTPHeaders = [String: String]()
    fileprivate var fileSuffixName:String = ""
    fileprivate var images: [UIImage] = [UIImage]()
    fileprivate var multipartName:String=""
    
    public init(){
        
    }
    
    
    public func setMultiparName(multipartName:String)->HttpUploadRequestParams{
        self.multipartName=multipartName
        return self
    }
    
    func getMultiparName()->String{
        return multipartName
    }
    
    public func setImages(images: [UIImage]?) -> HttpUploadRequestParams {
        self.images=images!
        return self
    }
    
    func getImages()->[UIImage] {
        return images
    }
    
    public func setFileSuffixName(fileSuffixName:String)->HttpUploadRequestParams{
        self.fileSuffixName=fileSuffixName
        return self
    }
    
    func getFileSuffixName()->String{
        return fileSuffixName
    }
    
    public func setReqUrl(requestUrl:String) -> HttpUploadRequestParams {
        self.requestUrl=requestUrl
        return self
    }
    
    func getReqUrl()->String{
        return requestUrl
    }
    
    
    
    public func setParams(params: [String:String])->HttpUploadRequestParams{
        self.params=params
        return self
    }
    
    public func setParam(key:String,param:String)->HttpUploadRequestParams{
        self.params[key]=param
        return self
    }
    
    
    func getParams() -> [String:String] {
        return params
    }
    
    
    public func setHttpHeaders(headers: HTTPHeaders)->HttpUploadRequestParams{
        self.headers=headers
        return self
    }
    
    public func setHttpHeader(key:String,header:String) -> HttpUploadRequestParams {
        self.headers[key]=header
        return self
    }
    
    func getHttpHeaders() -> HTTPHeaders {
        return headers
    }
    
    
    func build(){
        
        
    }
    
}
