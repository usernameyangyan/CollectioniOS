//
//  UIImageImageLoader.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/8.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

extension UIImage {
    internal static func process(data: Data) -> UIImage? {
           switch data.fileType {
           case .gif:
               guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
               let result = source.process()
               return UIImage.animatedImage(with: result.images, duration: result.duration)
           case .png, .jpeg, .tiff, .webp, .Unknown:
               return UIImage(data: data)
           }
       }
}
