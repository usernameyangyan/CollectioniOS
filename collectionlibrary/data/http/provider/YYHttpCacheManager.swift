//
//  YYHttpCacheManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public enum YYHttpExpiry {
    /// Object will be expired in the nearest future
    case never
    /// Object will be expired in the specified amount of seconds
    case seconds(TimeInterval)
    /// Object will be expired on the specified date
    case date(Date)
    
    /// Returns the appropriate date object
    public var expiry: Expiry {
        switch self {
        case .never:
            return Expiry.never
        case .seconds(let seconds):
            return Expiry.seconds(seconds)
        case .date(let date):
            return Expiry.date(date)
        }
    }
    public var isExpired: Bool {
        return expiry.isExpired
    }
}

struct YYHttpCacheModel: Codable {
    var data: Data?
    var dataDict: Dictionary<String, Data>?
    init() { }
}

class YYHttpCacheManager: NSObject {
    static let `default` = YYHttpCacheManager()
    /// Manage storage
    private var storage: Storage<YYHttpCacheModel>?
    /// init
    override init() {
        super.init()
        expiryConfiguration()
    }
    var expiry: YYHttpExpiry = .never
    
    func expiryConfiguration(expiry: YYHttpExpiry = .never) {
        self.expiry = expiry
        let diskConfig = DiskConfig(
            name: "DaisyCache",
            expiry: expiry.expiry
        )
        let memoryConfig = MemoryConfig(expiry: expiry.expiry)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: YYHttpCacheModel.self))
        } catch {
            
            if(DataManager.DataForHttp.GlobalSetting.showHttpRequestLog){
                Logger.info("============获取缓存发生错误===============")
            }
        
        }
    }
    
    /// 清除所有缓存
    ///
    /// - Parameter completion: completion
    func removeAllCache(completion: @escaping (_ isSuccess: Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    
    /// 根据key值清除缓存
    ///
    /// - Parameters:
    ///   - cacheKey: cacheKey
    ///   - completion: completion
    func removeObjectCache(_ cacheKey: String, completion: @escaping (_ isSuccess: Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    
    /// 读取缓存
    ///
    /// - Parameter key: key
    /// - Returns: model
    func objectSync(forKey key: String) -> YYHttpCacheModel? {
        do {
            ///过期清除缓存
            if let isExpire = try storage?.isExpiredObject(forKey: key), isExpire {
                removeObjectCache(key) { (_) in }
                return nil
            } else {
                return (try storage?.object(forKey: key)) ?? nil
            }
        } catch {
            return nil
        }
    }
    
    /// 异步缓存
    ///
    /// - Parameters:
    ///   - object: model
    ///   - key: key
    func setObject(_ object: YYHttpCacheModel, forKey key: String,expiry:Expiry?=nil) {
        storage?.async.setObject(object, forKey: key, expiry: expiry, completion: { (result) in
//            switch result {
//            case .value(_):
//                YYHttpLog("缓存成功")
//            case .error(let error):
//                YYHttpLog("缓存失败: \(error)")
//            }
        })
    }
}

