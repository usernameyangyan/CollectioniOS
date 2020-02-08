//
//  YYHttpDowloadUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class YYHttpDowloadUtils{
    
    
    typealias HttpSuccessResultBlock = ((_ requestSuccessResult:String)->Void)?
    typealias HttpFailureResultBlock = ((_ requestFailureResult:String)->Void)?
    typealias HttpDownloadProgressBlock = ((_ downloadProgress:Double)->Void)?
    typealias HttpDownloadResumeBlock = (()->Void)?
    
    
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
        
        
        
        if(YYHttpGlobalSetting.showHttpRequestLog){
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














