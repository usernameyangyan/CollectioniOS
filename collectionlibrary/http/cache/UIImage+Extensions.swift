//
//  UIImage+Extensions.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

/// Helper UIImage extension.
extension UIImage {
  /// Checks if image has alpha component
  var hasAlpha: Bool {
    let result: Bool

    guard let alpha = cgImage?.alphaInfo else {
      return false
    }

    switch alpha {
    case .none, .noneSkipFirst, .noneSkipLast:
      result = false
    default:
      result = true
    }

    return result
  }

  /// Convert to data
  func cache_toData() -> Data? {
    return hasAlpha
        ? self.pngData()
        : self.jpegData(compressionQuality: 1.0)
  }
}
