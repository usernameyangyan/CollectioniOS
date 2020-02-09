//
//  Const.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

struct Const {
    
    struct StatusBar {
        
        static var maxY: CGFloat {
            return UIApplication.shared.statusBarFrame.maxY
        }
    }
    
    struct NavigationBar {
        
        static let height: CGFloat = 44.0
        
        static let layoutPaddings: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        static let layoutMargins: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    }
}

