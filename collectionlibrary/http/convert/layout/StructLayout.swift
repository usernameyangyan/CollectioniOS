//
//  StructLayout.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//


struct StructLayout: ModelLayout {
    let kind: UnsafeRawPointer
    /// An out-of-line description of the type
    var description: UnsafeMutablePointer<StructDescriptor>
}
