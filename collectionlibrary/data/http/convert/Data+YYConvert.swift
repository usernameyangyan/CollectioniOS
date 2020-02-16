//
//  Data+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension Data: YYCompatible {}
extension NSData: YYCompatible {}

public extension YYConvert where Base == Data {
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M? {
        return model(type: type) as? M
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible? {
        if let json = JSONSerialization.yy_JSON(base, [String: Any].self) {
            return json.yy.model(type: type)
        }
        Logger.error("Failed to get JSON from JSONData.")
        return nil
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray<M: Convertible>(_ type: M.Type) -> [M] {
        return modelArray(type: type) as! [M]
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray(type: Convertible.Type) -> [Convertible] {
        if let json = JSONSerialization.yy_JSON(base, [Any].self) {
            return json.yy.modelArray(type: type)
        }
        Logger.error("Failed to get JSON from JSONData.")
        return []
    }
}

public extension YYConvert where Base: NSData {
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M? {
        return (base as Data).yy.model(type)
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible? {
        return (base as Data).yy.model(type: type)
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray<M: Convertible>(_ type: M.Type) -> [M] {
        return (base as Data).yy.modelArray(type)
    }
    
    /// JSONObjectArray -> ModelArray
    func modelArray(type: Convertible.Type) -> [Convertible] {
        return (base as Data).yy.modelArray(type: type)
    }
}

extension Data {
    func yy_fastModel(_ type: Convertible.Type) -> Convertible? {
        if let json = JSONSerialization.yy_JSON(self, [String: Any].self) {
            return json.yy_fastModel(type)
        }
        Logger.error("Failed to get JSON from JSONData.")
        return nil
    }
}
