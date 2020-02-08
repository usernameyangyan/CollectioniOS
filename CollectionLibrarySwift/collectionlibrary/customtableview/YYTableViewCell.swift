//
//  YYTableViewCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import Foundation

open class YYTableViewCell: UITableViewCell {
    public var item: YYTableViewItem!

    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open func cellWillAppear() {}

    open func cellDidAppear() {
        let item = self.item as YYTableViewItem
        if item.isHideSeparator {
            separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: bounds.size.width - 15)
        } else {
            separatorInset = UIEdgeInsets(top: 0, left: item.separatorLeftMargin, bottom: 0, right: 0)
        }
    }

    open func cellDidDisappear() {}

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

