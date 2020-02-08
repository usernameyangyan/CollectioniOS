//
//  YYHttpRequestAndCacheSetting.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/21.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


class YYHttpGlobalSetting{
    
    public  static var showHttpRequestLog:Bool=false
    
    /**==============================设置全区参数==============================================**/
    /// 缓存过期时间
    ///
    /// - Parameter expiry: 参考 DaisyExpiry
    public static func cacheTimeOutWithClear(expiry: YYHttpExpiry) {
        YYHttpCacheManager.default.expiryConfiguration(expiry: expiry)
    }
    
    /// 超时时间
    ///
    /// - Parameter timeInterval: 超时时间
    public static func timeoutIntervalForRequest(_ timeInterval :TimeInterval) {
        YYHttpRequestManager.default.timeoutIntervalForRequest(timeInterval)
    }
}


