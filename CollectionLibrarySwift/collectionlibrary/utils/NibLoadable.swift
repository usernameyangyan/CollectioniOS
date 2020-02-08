//
//  YYXibUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/16.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

// 协议
protocol NibLoadable {
    // 具体实现写到extension内
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
