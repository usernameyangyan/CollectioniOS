//
//  Date+Extensions.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

/**
 Helper NSDate extension.
 */
extension Date {

  /// Checks if the date is in the past.
  var inThePast: Bool {
    return timeIntervalSinceNow < 0
  }
}
