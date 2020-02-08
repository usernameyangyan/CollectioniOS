//
//  YYHttpUploadUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


public class YYHttpUploadUtils<T:Convertible>{
    typealias HttpSuccessResultBlock = ((_ requestSuccessResult:T)->Void)?
    typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
    typealias HttpProgressResultBlock = ((_ requestProgress:Double)->Void)?
    
    
    static func upload(httpRequestParams:HttpUploadRequestParams,requestSuccessResult:HttpSuccessResultBlock,requestFailureResult:HttpFailureResultBlock,requestProgress:HttpProgressResultBlock){
        
        
        let url=httpRequestParams.getReqUrl()
        let multipartName = httpRequestParams.getMultiparName()
        
        if(httpRequestParams.getReqUrl() == ""){
            Logger.error("缺失请求Url")
            return
        }
        
        if(YYHttpGlobalSetting.showHttpRequestLog){
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
