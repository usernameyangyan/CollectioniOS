//
//  ParamsSerializationJsonTool.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/20.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


public class ParamsSerializationJsonTool{
    public static func paramsSerializationJson(param: [String:Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            let paramString = String.init(data: data, encoding: String.Encoding.utf8)
            return paramString!
        } catch let error {
            print("paramsSerializationJson --> error = \(error)")
            return ""
        }
    }
}
