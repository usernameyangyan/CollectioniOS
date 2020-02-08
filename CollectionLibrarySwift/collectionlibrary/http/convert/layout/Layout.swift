//
//  Layout.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

protocol Layout {
    // Only valid for non-class metadata
    var kind: UnsafeRawPointer { get }
}

protocol NominalLayout: Layout {
    associatedtype DescriptorType: NominalDescriptor
    var description: UnsafeMutablePointer<DescriptorType> { get }
    var genericTypeOffset: Int { get }
}

extension NominalLayout {
    var genericTypeOffset: Int { return 2 }
}

protocol ModelLayout: NominalLayout where DescriptorType: ModelDescriptor  {}
