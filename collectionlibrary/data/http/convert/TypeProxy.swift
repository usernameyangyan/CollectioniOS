//
//  TypeProxy.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

protocol TypeProxy: Convertible {}

extension TypeProxy {
    static func `is`(_ value: Any) -> Bool {
        return value is Self
    }
    
    static func `is`(_ type: Any.Type) -> Bool {
        return type is Self.Type
    }
    
    static func `as`(_ value: Any) -> Self? {
        return value as? Self
    }
    
    static func `as`(_ type: Any.Type) -> Self.Type? {
        return type as? Self.Type
    }
}

func typeProxy(_ type: Any.Type) -> TypeProxy.Type {
    // Any.Type(8 bytes) + Int(8 bytes) == Protocol.Type(16 bytes)
    return (type, 0)  ~>> TypeProxy.Type.self
}

typealias TypeKey = UInt
func typeKey(_ type: Any.Type) -> TypeKey {
    return type ~>> TypeKey.self
}

