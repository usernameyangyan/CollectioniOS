//
//  YYHttpUploadManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class YYHttpUploadManager{
    
    static let `default` = YYHttpUploadManager()
    /// 下载任务管理
    private var requestTasks = [String: YYHttpUploadloadTaskManager]()
    
    
    //上台图片上传
    func upload(urlString : String,multipartName:String, params:[String:String]?,headers: HTTPHeaders? = nil, images: [UIImage],suffixName:String?, success: @escaping (_ response : String?) -> (), failture : @escaping (_ error : Error)->(),progress: @escaping ((_ progress:Double)->()))->YYHttpUploadloadTaskManager{
        
        let key = cacheKey(urlString, params, nil)
        var taskManager : YYHttpUploadloadTaskManager?
        if requestTasks[key] == nil {
            taskManager = YYHttpUploadloadTaskManager()
            requestTasks[key] = taskManager
        } else {
            taskManager = requestTasks[key]
        }
        
        
        taskManager?.upload(urlString: urlString,multipartName:multipartName, params: params,headers:headers , images: images,suffixName:suffixName, success: success, failture: failture,progress: progress)
        
        return taskManager!
    }
}


// MARK: - taskManager
public class YYHttpUploadloadTaskManager {
    
    
    open func build(){}
    
    
    lazy var manager: SessionManager = {
        //        let configuration = URLSessionConfiguration.background(withIdentifier: "com.\(key).app.background")
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    
    //上台图片上传
    fileprivate func upload(urlString : String,multipartName:String, params:[String:String]?,headers: HTTPHeaders? = nil, images: [UIImage],suffixName:String?, success: @escaping (_ response : String?) -> (), failture : @escaping (_ error : Error)->(),progress: @escaping ((_ progress:Double)->())) {
        manager.upload(multipartFormData: { multipartFormData in
            if params != nil {
                for (key, value) in params! {
                    //参数的上传
                    multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                }
            }
            for (index, value) in images.enumerated() {
                let imageData = value.jpegData(compressionQuality: 1.0)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let str = formatter.string(from: Date())
                let fileName = str+"\(index)"+suffixName!
                
                // 以文件流格式上传
                // 批量上传与单张上传，后台语言为java或.net等
                
                
                multipartFormData.append(imageData!, withName: multipartName, fileName: fileName, mimeType: "image/jpeg")
            }
        },
                       to: urlString,
                       headers: headers,
                       encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.uploadProgress(closure: {
                                vlaue in
                                progress(vlaue.fractionCompleted)
                            }).responseString(completionHandler: {
                                response in
                                let result = response.result
                                if result.isSuccess {
                                    success(response.value)
                                }
                            })
                        case .failure(let encodingError):
                            failture(encodingError)
                        }
        })
    }
}
