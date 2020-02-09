//
//  StructType.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

public class StructType: ModelType, PropertyType, LayoutType {
    private(set) var layout: UnsafeMutablePointer<StructLayout>!
    
    override func build() {
        super.build()
        
        layout = builtLayout()
        properties = builtProperties()
        genericTypes = builtGenericTypes()
    }
    
    override public var description: String {
        return "\(name) { kind = \(kind), properties = \(properties ?? []), genericTypes = \(genericTypes ?? []) }"
    }
}
