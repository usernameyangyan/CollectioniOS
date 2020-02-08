//
//  YYHttpValue.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

//// MARK: - Result
public struct YYHttpValue<Value> {
    
    public let isCacheData: Bool
    public let result: HttpBaseResult<Value>
    public let response: HTTPURLResponse?
    
    init(isCacheData: Bool, result: HttpBaseResult<Value>, response: HTTPURLResponse?) {
        self.isCacheData = isCacheData
        self.result = result
        self.response = response
    }
}

