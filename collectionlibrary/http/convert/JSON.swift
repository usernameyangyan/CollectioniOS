//
//  JSON.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

// MARK: Model -> JSON
public func JSONObject<M: Convertible>(from model: M) -> [String: Any] {
    return model.yy_JSONObject()
}

public func JSONObjectArray<M: Convertible>(from models: [M]) -> [[String: Any]] {
    return models.yy.JSONObjectArray()
}

//public func JSONArray(from value: [Any]) -> [Any] {
//    return value.yy.JSONArray()
//}
//
//public func JSON(from value: Any) -> Any? {
//    return Values.JSONValue(value)
//}

public func JSONString(from value: Any,
                       prettyPrinted: Bool = false) -> String {
    return Values.JSONString(value, prettyPrinted: prettyPrinted) ?? ""
}
