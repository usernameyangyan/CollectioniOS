//
//  Model.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

// MARK: - JSON -> Model
public func model<M: Convertible>(from json: [String: Any],
                                  _ type: M.Type) -> M {
    return json.yy.model(type)
}

public func model(from json: [String: Any],
                  type: Convertible.Type) -> Convertible {
    return json.yy.model(type: type)
}

public func model<M: Convertible>(from json: [NSString: Any],
                                  _ type: M.Type) -> M {
    return json.yy.model(type)
}

public func model(from json: [NSString: Any],
                  type: Convertible.Type) -> Convertible {
    return json.yy.model(type: type)
}

public func model<M: Convertible>(from json: NSDictionary,
                                  _ type: M.Type) -> M? {
    return json.yy.model(type)
}

public func model(from json: NSDictionary,
                  type: Convertible.Type) -> Convertible? {
    return json.yy.model(type: type)
}

public func model<M: Convertible>(from jsonString: String,
                                  _ type: M.Type) -> M? {
    return jsonString.yy.model(type)
}

public func model(from jsonString: String,
                  type: Convertible.Type) -> Convertible? {
    return jsonString.yy.model(type: type)
}

public func model<M: Convertible>(from jsonString: NSString,
                                  _ type: M.Type) -> M? {
    return jsonString.yy.model(type)
}

public func model(from jsonString: NSString,
                  type: Convertible.Type) -> Convertible? {
    return jsonString.yy.model(type: type)
}

public func model<M: Convertible>(from jsonData: Data,
                                  _ type: M.Type) -> M? {
    return jsonData.yy.model(type)
}

public func model(from jsonData: Data,
                  type: Convertible.Type) -> Convertible? {
    return jsonData.yy.model(type: type)
}

public func model<M: Convertible>(from jsonData: NSData,
                                  _ type: M.Type) -> M? {
    return jsonData.yy.model(type)
}

public func model(from jsonData: NSData,
                  type: Convertible.Type) -> Convertible? {
    return jsonData.yy.model(type: type)
}

public func modelArray<M: Convertible>(from json: [Any],
                                       _ type: M.Type) -> [M] {
    return json.yy.modelArray(type)
}

public func modelArray(from json: [Any],
                       type: Convertible.Type) -> [Convertible] {
    return json.yy.modelArray(type: type)
}

public func modelArray<M: Convertible>(from json: NSArray,
                                       _ type: M.Type) -> [M] {
    return json.yy.modelArray(type)
}

public func modelArray(from json: NSArray,
                       type: Convertible.Type) -> [Convertible] {
    return json.yy.modelArray(type: type)
}

public func modelArray<M: Convertible>(from jsonString: String,
                                       _ type: M.Type) -> [M] {
    return jsonString.yy.modelArray(type)
}

public func modelArray(from jsonString: String,
                       type: Convertible.Type) -> [Convertible] {
    return jsonString.yy.modelArray(type: type)
}

public func modelArray<M: Convertible>(from jsonString: NSString,
                                       _ type: M.Type) -> [M] {
    return jsonString.yy.modelArray(type)
}

public func modelArray(from jsonString: NSString,
                       type: Convertible.Type) -> [Convertible] {
    return jsonString.yy.modelArray(type: type)
}

public func modelArray<M: Convertible>(from jsonData: Data,
                                       _ type: M.Type) -> [M] {
    return jsonData.yy.modelArray(type)
}

public func modelArray(from jsonData: Data,
                       type: Convertible.Type) -> [Convertible] {
    return jsonData.yy.modelArray(type: type)
}

public func modelArray<M: Convertible>(from jsonData: NSData,
                                       _ type: M.Type) -> [M] {
    return jsonData.yy.modelArray(type)
}

public func modelArray(from jsonData: NSData,
                       type: Convertible.Type) -> [Convertible] {
    return jsonData.yy.modelArray(type: type)
}


