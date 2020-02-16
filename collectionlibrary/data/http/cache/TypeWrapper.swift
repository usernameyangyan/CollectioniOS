//
//  TypeWrapper.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

/// Used to wrap Codable object
public struct TypeWrapper<T: Codable>: Codable {
  enum CodingKeys: String, CodingKey {
    case object
  }

  public let object: T

  public init(object: T) {
    self.object = object
  }
}
