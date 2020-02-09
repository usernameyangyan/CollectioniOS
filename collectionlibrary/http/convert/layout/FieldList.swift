//
//  FieldList.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/19.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

struct FieldList<Item> {
    private let item: Item
    mutating func ptr(_ index: Int) -> UnsafeMutablePointer<Item> {
        return withUnsafeMutablePointer(to: &self) {
            ($0 + index).yy_raw ~> Item.self
        }
    }
    
    mutating func item(_ index: Int) -> Item {
        return withUnsafeMutablePointer(to: &self) {
            $0[index].item
        }
    }
}
