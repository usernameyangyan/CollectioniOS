//
//  MvpPresenter.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


protocol MvpView {
    func refreshUI(value:Result<Array<ContentInfo>>)
}

class MvpPresenter:BasePresenter{
    
    func requestData() {
        
        let urlStr = "https://api.apiopen.top/getJoke?page=1&count=20&type=video"
        
        let httpParams:HttpRequestParams=HttpRequestParams()
        httpParams
            .setRequestType(requestType: .reqStringUrl)
            .setReqUrl(requestUrl: urlStr)
            .setReponseType(responseType: .netWork)
            .setHttpTypeAndReqParamType(httpTypeAndReqParamType: .get)
            .build()
        
        DataManager.DataForHttp.HttpOfNormal.Request<Result<Array<ContentInfo>>>.request(httpRequestParams: httpParams, requestSuccessResult: {
            value in
            
            
            (self.mView as! MVPUseControllerView).refreshUI(value: value)
            
        }, requestFailureResult: {
            error in
        })
        
        
    }
    
    
    
}
