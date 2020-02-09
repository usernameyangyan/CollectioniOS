//
//  YYConvert.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

public struct YYConvert<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

// MARK: - protocol for normal types
public protocol YYCompatible {}
public extension YYCompatible {
    static var yy: YYConvert<Self>.Type {
        get { return YYConvert<Self>.self }
        set {}
    }
    var yy: YYConvert<Self> {
        get { return YYConvert(self) }
        set {}
    }
}

// MARK: - protocol for types with a generic parameter
public struct YYGeneric<Base, T> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
public protocol YYGenericCompatible {
    associatedtype T
}
public extension YYGenericCompatible {
    static var yy: YYGeneric<Self, T>.Type {
        get { return YYGeneric<Self, T>.self }
        set {}
    }
    var yy: YYGeneric<Self, T> {
        get { return YYGeneric(self) }
        set {}
    }
}

// MARK: - protocol for types with two generic parameter2
public struct YYGeneric2<Base, T1, T2> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
public protocol YYGenericCompatible2 {
    associatedtype T1
    associatedtype T2
}
public extension YYGenericCompatible2 {
    static var yy: YYGeneric2<Self, T1, T2>.Type {
        get { return YYGeneric2<Self, T1, T2>.self }
        set {}
    }
    var yy: YYGeneric2<Self, T1, T2> {
        get { return YYGeneric2(self) }
        set {}
    }
}

