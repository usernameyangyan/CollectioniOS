//
//  Array+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension NSArray: YYCompatible {}
extension Array: YYCompatible {}
extension Set: YYCompatible {}
extension NSSet: YYCompatible {}

public extension YYConvert where Base: ExpressibleByArrayLiteral & Sequence {
    /// JSONObjectArray -> EnumArray
    func enumArray<M: ConvertibleEnum>(_ type: M.Type) -> [M] {
        return enumArray(type: type) as! [M]
    }
    
    /// JSONObjectArray -> EnumArray
    func enumArray(type: ConvertibleEnum.Type) -> [ConvertibleEnum] {
        guard let _ = Metadata.type(type) as? EnumType else { return [] }
        return base.compactMap {
            let vv = Values.value($0, type.yy_valueType)
            return type.yy_convert(from: vv as Any)
        }
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray<M: Convertible>(_ type: M.Type) -> [M] {
        return modelArray(type: type) as! [M]
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray(type: Convertible.Type) -> [Convertible] {
        guard let mt = Metadata.type(type) as? ModelType,
            let _ = mt.properties
            else { return [] }
        return base.compactMap {
            switch $0 {
            case let dict as [String: Any]: return dict.yy_fastModel(type)
            case let dict as Data: return dict.yy_fastModel(type)
            case let dict as String: return dict.yy_fastModel(type)
            default: return nil
            }
        }
    }
    
    /// ModelArray -> JSONObjectArray
    func JSONObjectArray() -> [[String: Any]] {
        return base.compactMap {
            ($0~! as? Convertible)?.yy_JSONObject()
        }
    }
    
    /// Array -> JSONArray
    func JSONArray() -> [Any] {
        return Values.JSONValue(base) as! [Any]
    }
    
    /// Array -> JSONString
    func JSONString(prettyPrinted: Bool = false) -> String {
        if let str = JSONSerialization.yy_string(JSONArray(),
                                                 prettyPrinted: prettyPrinted) {
            return str
        }
        Logger.error("Failed to get JSONString from JSON.")
        return ""
    }
}

