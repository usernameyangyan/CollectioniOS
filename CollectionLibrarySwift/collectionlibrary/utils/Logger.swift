//
//  Logger.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public struct Logger {
    private static func _log<T>(_ title: String, _ msg: T) {
        #if DEBUG
        print("\(title)：\(msg)")
        #endif
    }
    
    static func error<T>(_ msg: T) {
        _log("error", msg)
    }
    
    static func warnning<T>(_ msg: T) {
        _log("warning", msg)
    }
    
    
    static func info<T>(_ msg: T) {
        _log("info", msg)
    }
}

