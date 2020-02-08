//
//  Storage+Transform.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public extension Storage {
  func transformData() -> Storage<Data> {
    let storage = transform(transformer: TransformerFactory.forData())
    return storage
  }

  func transformImage() -> Storage<Image> {
    let storage = transform(transformer: TransformerFactory.forImage())
    return storage
  }

  func transformCodable<U: Codable>(ofType: U.Type) -> Storage<U> {
    let storage = transform(transformer: TransformerFactory.forCodable(ofType: U.self))
    return storage
  }
}
