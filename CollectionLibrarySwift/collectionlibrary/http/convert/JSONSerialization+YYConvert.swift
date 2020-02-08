//
//  JSONSerialization+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension JSONSerialization {
    static func yy_JSON<T>(_ string: String, _ type: T.Type) -> T? {
        return string.data(using: .utf8).flatMap { yy_JSON($0, type) }
    }
    
    static func yy_JSON<T>(_ data: Data, _ type: T.Type) -> T? {
        return try! jsonObject(with: data,
                               options: .allowFragments) as? T
    }
    
    static func yy_string(_ json: Any?,
                          prettyPrinted: Bool = false) -> String? {
        guard let value = json.yy_value else { return nil }
        guard value is [Any] || value is [String: Any] else {
            return "\(value)"
        }
        guard let data = try? data(withJSONObject: value,
                                   options: prettyPrinted ? [.prettyPrinted] : [])
            else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

