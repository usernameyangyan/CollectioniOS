//
//  String+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension String: YYCompatible {}
extension NSString: YYCompatible {}

public extension YYConvert where Base: ExpressibleByStringLiteral {
    /// from underline-cased to camel-cased
    ///
    /// e.g. from `my_test_name` to `myTestName`
    func camelCased() -> String {
        guard let str = base as? String else { return "" }
        var newStr = ""
        var upper = false
        for c in str {
            if c == "_" {
                upper = true
                continue
            }
            
            if upper, newStr.count > 0 {
                newStr += c.uppercased()
            } else {
                newStr.append(c)
            }
            upper = false
        }
        return newStr
    }
    
    /// from camel-cased to underline-cased
    ///
    /// e.g. from `myTestName` to `my_test_name`
    func underlineCased() -> String {
        guard let str = base as? String else { return "" }
        var newStr = ""
        for c in str {
            if c.isUppercase {
                newStr += "_"
                newStr += c.lowercased()
            } else {
                newStr.append(c)
            }
        }
        return newStr
    }
    
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M? {
        return model(type: type) as? M
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible? {
        guard let string = base as? String else { return nil }
        return string.yy_fastModel(type)
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray<M: Convertible>(_ type: M.Type) -> [M] {
        return modelArray(type: type) as! [M]
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray(type: Convertible.Type) -> [Convertible] {
        guard let string = base as? String else { return [] }
        if let json = JSONSerialization.yy_JSON(string, [Any].self) {
            return json.yy.modelArray(type: type)
        }
        Logger.error("Failed to get JSON from JSONString.")
        return []
    }
}

extension String {
    func yy_fastModel(_ type: Convertible.Type) -> Convertible? {
        if let json = JSONSerialization.yy_JSON(self, [String: Any].self) {
            return json.yy_fastModel(type)
        }
        Logger.error("Failed to get JSON from JSONString.")
        return nil
    }
}
