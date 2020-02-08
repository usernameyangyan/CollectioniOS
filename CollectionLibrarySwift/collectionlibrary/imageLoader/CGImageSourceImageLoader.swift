//
//  CGImageSource+ImageLoader.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/8.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit
import ImageIO

extension CGImageSource {

    internal var imageCount: Int {
        return CGImageSourceGetCount(self)
    }

    internal func process() -> (images: [UIImage], duration: TimeInterval) {
        var images = [UIImage]()
        let count = imageCount
        let duration: Double = Double(count) * 0.2 // TODO: implementation
        for i in 0 ..< count {
            if let cgImage = getCGImage(index: i) {
                images.append(UIImage(cgImage: cgImage))
            }
        }

        return (images, duration)
    }

    internal func getCGImage(index: Int) -> CGImage? {
        return CGImageSourceCreateImageAtIndex(self, index, nil)
    }

}
