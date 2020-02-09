//
//  Optional+Extension.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

public extension Optional {
  func unwrapOrThrow(error: Error) throws -> Wrapped {
    if let value = self {
      return value
    } else {
      throw error
    }
  }
}
