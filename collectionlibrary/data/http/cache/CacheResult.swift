//
//  Result.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

/// Used for callback in async operations.
public enum CacheResult<T> {
  case value(T)
  case error(Error)

  public func map<U>(_ transform: (T) -> U) -> CacheResult<U> {
    switch self {
    case .value(let value):
      return CacheResult<U>.value(transform(value))
    case .error(let error):
      return CacheResult<U>.error(error)
    }
  }
}
