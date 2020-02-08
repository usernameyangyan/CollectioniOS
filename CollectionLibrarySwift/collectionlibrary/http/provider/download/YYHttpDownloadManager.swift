//
//  YYDownloadManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

// MARK: - downloadManager
class YYHttpDownloadManager {
    static let `default` = YYHttpDownloadManager()
    /// 下载任务管理
    fileprivate var downloadTasks = [String: YYHttpDownloadTaskManager]()
    
    func download(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        dynamicParams: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        fileName: String? = nil)
        ->YYHttpDownloadTaskManager
    {
        let key = cacheKey(url, parameters, dynamicParams)
        let taskManager = YYHttpDownloadTaskManager(url, parameters: parameters, dynamicParams: dynamicParams)
        var tempParam = parameters==nil ? [:] : parameters!
        let dynamicTempParam = dynamicParams==nil ? [:] : dynamicParams!
        dynamicTempParam.forEach { (arg) in
            tempParam[arg.key] = arg.value
        }
        taskManager.download(url, method: method, parameters: tempParam, encoding: encoding, headers: headers, fileName: fileName)
        self.downloadTasks[key] = taskManager
        taskManager.cancelCompletion = {
            self.downloadTasks.removeValue(forKey: key)
        }
        return taskManager
    }
    /// 暂停下载
    func cancel(_ url: String, parameters: Parameters?, dynamicParams: Parameters? = nil) {
        let key = cacheKey(url, parameters, dynamicParams)
        let task = downloadTasks[key]
        task?.downloadRequest?.cancel()
        NotificationCenter.default.post(name: NSNotification.Name("DaisyDownloadCancel"), object: nil)
    }
    
    // Cancel all tasks
    func cancelAll() {
        for (key, task) in downloadTasks {
            task.downloadRequest?.cancel()
            task.cancelCompletion = {
                self.downloadTasks.removeValue(forKey: key)
            }
        }
    }
    
    /// 删除单个下载
    func delete(_ url: String, parameters: Parameters? , dynamicParams: Parameters? = nil, completion: @escaping (Bool)->()) {
        let key = cacheKey(url, parameters, dynamicParams)
        if let task = downloadTasks[key] {
            task.downloadRequest?.cancel()
            task.cancelCompletion = {
                self.downloadTasks.removeValue(forKey: key)
                YYHttpCacheManager.default.removeObjectCache(key, completion: completion)
            }
        } else {
            if let path = getFilePath(key)
            { /// 下载完成了
                do {
                    let arr = path.components(separatedBy: "/")
                    let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                    let fileURL = cachesURL.appendingPathComponent(arr.last!)
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    
                }
            }
            YYHttpCacheManager.default.removeObjectCache(key, completion: completion)
        }
    }
    /// 下载完成路径
    func downloadFilePath(_ url: String, parameters: Parameters?, dynamicParams: Parameters? = nil) -> URL? {
        let key = cacheKey(url, parameters, dynamicParams)
        if let path = getFilePath(key),
            let pathUrl = URL(string: path) {
            return pathUrl
        }
        return nil
    }
    /// 下载百分比
    func downloadPercent(_ url: String, parameters: Parameters?, dynamicParams: Parameters? = nil) -> Double {
        let key = cacheKey(url, parameters, dynamicParams)
        let percent = getProgress(key)
        return percent
    }
    /// 下载状态
    func downloadStatus(_ url: String, parameters: Parameters?, dynamicParams: Parameters? = nil) -> DownloadStatus {
        let key = cacheKey(url, parameters, dynamicParams)
        let task = downloadTasks[key]
        if downloadPercent(url, parameters: parameters) == 1 { return .complete }
        return task?.downloadStatus ?? .suspend
    }
    /// 下载进度
    func downloadProgress(_ url: String, parameters: Parameters?, dynamicParams: Parameters? = nil, progress: @escaping ((Double)->())) -> YYHttpDownloadTaskManager? {
        let key = cacheKey(url, parameters, dynamicParams)
        if let task = downloadTasks[key], downloadPercent(url, parameters: parameters) < 1 {
            task.downloadProgress(progress: { pro in
                progress(pro)
            }).build()
            return task
        } else {
            let pro = downloadPercent(url, parameters: parameters)
            progress(pro)
            return nil
        }
    }
}

// MARK: - 下载状态
public enum DownloadStatus {
    case downloading
    case suspend
    case complete
}

// MARK: - taskManager
public class YYHttpDownloadTaskManager {
    fileprivate var downloadRequest: DownloadRequest?
    fileprivate var downloadStatus: DownloadStatus = .suspend
    fileprivate var cancelCompletion: (()->())?
    fileprivate var cccompletion: (()->())?
    var cacheDictionary = [String: Data]()
    private var key: String
    
    open func build(){}
    
    /// 初始化 --- 生成key
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 参数
    ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
    init(_ url: String,
         parameters: Parameters? = nil,
         dynamicParams: Parameters? = nil) {
        key = cacheKey(url, parameters, dynamicParams)
        NotificationCenter.default.addObserver(self, selector: #selector(downloadCancel), name: NSNotification.Name.init("DaisyDownloadCancel"), object: nil)
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { (_) in
            self.downloadRequest?.cancel()
        }
    }
    @objc fileprivate func downloadCancel() {
        self.downloadStatus = .suspend
    }
    @discardableResult
    fileprivate func download(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        fileName: String?)
        -> YYHttpDownloadTaskManager
    {
        let destination = downloadDestination(fileName)
        let resumeData = getResumeData(key)
        if let resumeData = resumeData {
            downloadRequest = manager.download(resumingWith: resumeData, to: destination)
        } else {
            downloadRequest = manager.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
        }
        downloadStatus = .downloading
        return self
    }
    
    lazy var manager: SessionManager = {
        //        let configuration = URLSessionConfiguration.background(withIdentifier: "com.\(key).app.background")
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    
    /// 下载进度
    
    public func downloadProgress(progress: @escaping ((Double) -> Void)) -> YYHttpDownloadTaskManager {
        downloadRequest?.downloadProgress(closure: { (pro) in
            self.saveProgress(pro.fractionCompleted)
            progress(pro.fractionCompleted)
        })
        return self
    }
    /// 响应
    public func response(completion: @escaping (HttpBaseResult<String>)->()) {
        downloadRequest?.responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                self.downloadStatus = .complete
                let str = response.destinationURL?.absoluteString
                if self.cancelCompletion != nil { self.cancelCompletion!() }
                completion(HttpBaseResult.success(str!))
            case .failure(let error):
                self.downloadStatus = .suspend
                self.saveResumeData(response.resumeData)
                if self.cancelCompletion != nil { self.cancelCompletion!() }
                completion(HttpBaseResult.failure(error))
            }
        })
    }
    /// 下载文件位置
    ///
    /// - Parameter fileName: 自定义文件名
    /// - Returns: 下载位置
    private func downloadDestination(_ fileName: String?) -> DownloadRequest.DownloadFileDestination {
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            if let fileName = fileName {
                let fileURL = cachesURL.appendingPathComponent(fileName)
                self.saveFilePath(fileURL.absoluteString)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                let fileURL = cachesURL.appendingPathComponent(response.suggestedFilename!)
                self.saveFilePath(fileURL.absoluteString)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        return destination
    }
    
    func saveProgress(_ progress: Double) {
        if let progressData = "\(progress)".data(using: .utf8) {
            cacheDictionary["progress"] = progressData
            var model = YYHttpCacheModel()
            model.dataDict = cacheDictionary
            YYHttpCacheManager.default.setObject(model, forKey: key)
        }
    }
    
    func saveResumeData(_ data: Data?) {
        cacheDictionary["resumeData"] = data
        var model = YYHttpCacheModel()
        model.dataDict = cacheDictionary
        YYHttpCacheManager.default.setObject(model, forKey: key)
    }
    
    func saveFilePath(_ filePath: String?) {
        if let filePathData = filePath?.data(using: .utf8) {
            cacheDictionary["filePath"] = filePathData
            var model = YYHttpCacheModel()
            model.dataDict = cacheDictionary
            YYHttpCacheManager.default.setObject(model, forKey: key)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



func getResumeData(_ url: String) -> Data? {
    let dic = getDictionary(url)
    if let data = dic["resumeData"] {
        return data
    }
    return nil
}

func getProgress(_ url: String) -> Double {
    let dic = getDictionary(url)
    if let progressData = dic["progress"],
        let progressString = String(data: progressData, encoding: .utf8),
        let progress = Double(progressString) {
        return progress
    }
    return 0
}

func getFilePath(_ url: String) -> String? {
    let dic = getDictionary(url)
    if let filePathData = dic["filePath"],
        let filePath = String(data: filePathData, encoding: .utf8) {
        return filePath
    }
    return nil
}

func getDictionary(_ url: String) -> Dictionary<String, Data> {
    if let dic = YYHttpCacheManager.default.objectSync(forKey: url)?.dataDict {
        return dic
    }
    return [:]
}


