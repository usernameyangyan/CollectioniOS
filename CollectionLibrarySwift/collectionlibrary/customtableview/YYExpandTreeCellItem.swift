//
//  YYExpandTreeCellItem.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

open class YYExpandTreeCellItem: YYTableViewItem {
    public var level: Int = 0
    public var isExpand = true
    public var arrNextLevel = [YYExpandTreeCellItem]()
    /// 展开或者收起下级cell的回调
    public var willExpand: ((YYExpandTreeCellItem) -> Void)?

    public override init() {
        super.init()
        selectionStyle = .none
        setSelectionHandler {[weak self] callBackItem in
            let item = callBackItem as! YYExpandTreeCellItem
            var arrItems = [YYExpandTreeCellItem]()
            if item.isExpand {
                // 点击之前是打开的，直接通过递归获取item
                YYExpandTreeCellItem.recursionForItem(item, outItems: &arrItems)
                item.isExpand = !item.isExpand
            } else {
                // 点击之前是关闭的，需要先改变isExpand属性（不这么做会导致这一个level下一级的level的cell不显示）
                item.isExpand = !item.isExpand
                YYExpandTreeCellItem.recursionForItem(item, outItems: &arrItems)
            }
            self?.willExpand?(item)
            if item.isExpand {
                item.section.insert(arrItems, afterItem: item, animate: .fade)
            } else {
                item.section.delete(arrItems, animate: .fade)
            }
        }
    }

    /// 递归获取一个item下面所有显示的item
    class func recursionForItem(_ item: YYExpandTreeCellItem, outItems: inout [YYExpandTreeCellItem]) {
        for subItem in item.arrNextLevel {
            if item.isExpand == true {
                outItems.append(subItem)
                if item.arrNextLevel.count != 0 {
                    recursionForItem(subItem, outItems: &outItems)
                }
            }
        }
    }
}

