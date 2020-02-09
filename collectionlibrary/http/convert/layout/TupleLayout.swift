//
//  TupleLayout.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

struct TupleLayout: Layout {
    let kind: UnsafeRawPointer
    let numElements: Int
    let labels: UnsafeMutablePointer<CChar>
    var elements: FieldList<TupleElement>
}

struct TupleElement {
    let type: Any.Type
    let offset: Int
}
