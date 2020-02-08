//
//  Types.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

#if os(iOS) || os(tvOS)
  import UIKit
  public typealias Image = UIImage
#elseif os(watchOS)

#elseif os(OSX)
  import AppKit
  public typealias Image = NSImage
#endif

