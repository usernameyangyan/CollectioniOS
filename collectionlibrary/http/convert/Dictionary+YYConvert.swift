//
//  Dictionary+YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension NSDictionary: YYCompatible {}
extension Dictionary: YYGenericCompatible {
    public typealias T = Value
}

public extension YYGeneric where Base == [String: T] {
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M {
        return model(type: type) as! M
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible {
        return base.yy_fastModel(type)
    }
}

public extension YYGeneric where Base == [NSString: T] {
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M {
        return (base as [String: Any]).yy.model(type)
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible {
        return (base as [String: Any]).yy.model(type: type)
    }
}

public extension YYConvert where Base: NSDictionary {
    /// JSONObject -> Model
    func model<M: Convertible>(_ type: M.Type) -> M? {
        return (base as? [String: Any])?.yy.model(type)
    }
    
    /// JSONObject -> Model
    func model(type: Convertible.Type) -> Convertible? {
        return (base as? [String: Any])?.yy.model(type: type)
    }
}

extension Dictionary where Key == String {
    func yy_fastModel(_ type: Convertible.Type) -> Convertible {
        var model: Convertible
        if let ns = type as? NSObject.Type {
            model = ns.newConvertible()
        } else {
            model = type.init()
        }
        model.yy_convert(from: self)
        return model
    }
    
    func yy_value(for modelPropertyKey: ModelPropertyKey) -> Any? {
        if let key = modelPropertyKey as? String {
            return _value(stringKey: key)
        }
        
        let keyArray = modelPropertyKey as! [String]
        for key in keyArray {
            if let value = _value(stringKey: key) {
                return value
            }
        }
        return nil
    }
    
    private func _value(stringKey: String) -> Any? {
        if let value = self[stringKey] {
            return value
        }

        let subkeys = stringKey.split(separator: ".")
        var value: Any? = self
        for subKey in subkeys {
            if let dict = value as? [String: Any] {
                value = dict[String(subKey)]
                // when nil, end the for-loop
                if value == nil { return nil }
            } else if let array = value as? [Any] {
                guard let index = Int(subKey),
                    case array.indices = index else { return nil }
                value = array[index]
            } else {
                break
            }
        }
        return value
    }
}

