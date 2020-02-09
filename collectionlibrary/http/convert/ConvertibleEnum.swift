//
//  ConvertibleEnum.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

public protocol ConvertibleEnum {
    static func yy_convert(from value: Any) -> Self?
    var yy_value: Any { get }
    static var yy_valueType: Any.Type { get }
}

public extension RawRepresentable where Self: ConvertibleEnum {
    static func yy_convert(from value: Any) -> Self? {
        return (value as? RawValue).flatMap { Self.init(rawValue: $0) }
    }
    var yy_value: Any { return rawValue }
    static var yy_valueType: Any.Type { return RawValue.self }
}
