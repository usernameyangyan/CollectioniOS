//
//  YYNetCacheKey.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//
import Foundation


/// 将参数字典转换成字符串后md5
func cacheKey(_ url: String, _ params: Dictionary<String, Any>?, _ dynamicParams: Dictionary<String, Any>?) -> String {
    /// c参数重复, `params`中过滤掉`dynamicParams`中的参数
    if let filterParams = params?.filter({ (key, _) -> Bool in
        return dynamicParams?.contains(where: { (key1, _) -> Bool in
            return key != key1
        }) ?? false
    }) {
        let str = "\(url)" + "\(sort(filterParams))"
        return MD5(str)
    } else {
        return MD5(url)
    }
}

/// 参数排序生成字符串
func sort(_ parameters: Dictionary<String, Any>?) -> String {
    var sortParams = ""
    if let params = parameters {
        let sortArr = params.keys.sorted { return $0 < $1 }
        sortArr.forEach({ (str) in
            if let value = params[str] {
                sortParams = sortParams.appending("\(str)=\(value)")
            } else {
                sortParams = sortParams.appending("\(str)=")
            }
        })
    }
    return sortParams
}
