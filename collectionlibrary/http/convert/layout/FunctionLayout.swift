//
//  FunctionLayout.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//


struct FunctionLayout: Layout {
    let kind: UnsafeRawPointer
    var flags: Int
    var parameters: FieldList<Any.Type>
}
