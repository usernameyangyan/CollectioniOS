//
//  YYTableViewSection.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

public typealias YYTableViewSectionBlock = (YYTableViewSection) -> ()

open class YYTableViewSection: NSObject {
    public  weak var tableViewManager: YYTableViewManager!
    public var items = [YYTableViewItem]()
    public var headerHeight: CGFloat!
    public var footerHeight: CGFloat!
    public var headerView: UIView?
    public var footerView: UIView?
    public var headerTitle: String?
    public var footerTitle: String?
    var headerWillDisplayHandler: YYTableViewSectionBlock?
    public func setHeaderWillDisplayHandler(_ block: YYTableViewSectionBlock?) {
        self.headerWillDisplayHandler = block
    }
    var headerDidEndDisplayHandler: YYTableViewSectionBlock?
    public func setHeaderDidEndDisplayHandler(_ block: YYTableViewSectionBlock?) {
        self.headerDidEndDisplayHandler = block
    }
    public var index: Int {
        get {
            let section = tableViewManager.sections.firstIndex(where: { (section) -> Bool in
                return section == self
            })
            return section!
        }
    }
    
    override public init() {
        super.init()
        self.items = []
        self.headerHeight = CGFloat.leastNormalMagnitude
        self.footerHeight = CGFloat.leastNormalMagnitude
    }
    
    
    public convenience init(headerView: UIView!) {
        self.init(headerView: headerView, footerView: nil)
    }
    
    public convenience init(footerView: UIView?) {
        self.init(headerView: nil, footerView: footerView)
    }
    
    public convenience init(headerView: UIView?, footerView: UIView?) {
        self.init()
        if let header = headerView {
            self.headerView = header
            self.headerHeight = header.frame.size.height
        }
        
        if let footer = footerView {
            self.footerView = footer
            self.footerHeight = footer.frame.size.height
        }
    }
    
    public func add(item: YYTableViewItem) {
        item.section = self
        item.tableViewManager = self.tableViewManager
        self.items.append(item)
    }
    
    public func remove(item: YYTableViewItem) {
        if let index = items.firstIndex(where: {$0 == item}) {
            items.remove(at: index)
        }else{
            print("item not in this section")
        }
    }
    
    public func removeAllItems() {
        self.items.removeAll()
    }
    
    public func replaceItemsFrom(array: [YYTableViewItem]!) {
        self.removeAllItems()
        self.items = self.items + array
    }
    
    public func insert(_ item: YYTableViewItem!, afterItem: YYTableViewItem, animate: UITableView.RowAnimation = .automatic) {
        if !self.items.contains(where: {$0 == afterItem}) {
            print("can't insert because afterItem did not in sections")
            return;
        }
        
        tableViewManager.tableView.beginUpdates()
        item.section = self
        item.tableViewManager = self.tableViewManager
        self.items.insert(item, at: self.items.firstIndex(where: {$0 == afterItem})! + 1)
        tableViewManager.tableView.insertRows(at: [item.indexPath], with: animate)
        tableViewManager.tableView.endUpdates()
    }
    
    public func insert(_ items: [YYTableViewItem], afterItem: YYTableViewItem, animate: UITableView.RowAnimation = .automatic) {
        if !self.items.contains(where: {$0 == afterItem}) {
            print("can't insert because afterItem did not in sections")
            return;
        }
        
        tableViewManager.tableView.beginUpdates()
        let newFirstIndex = self.items.firstIndex(where: {$0 == afterItem})! + 1
        self.items.insert(contentsOf: items, at: newFirstIndex)
        var arrNewIndexPath = [IndexPath]()
        for i in 0..<items.count {
            items[i].section = self
            items[i].tableViewManager = self.tableViewManager
            arrNewIndexPath.append(IndexPath(item: newFirstIndex + i, section: afterItem.indexPath.section))
        }
        tableViewManager.tableView.insertRows(at: arrNewIndexPath, with: animate)
        tableViewManager.tableView.endUpdates()
    }
    
    public func delete(_ itemsToDelete: [YYTableViewItem], animate: UITableView.RowAnimation = .automatic) {
        guard itemsToDelete.count > 0 else { return }
        tableViewManager.tableView.beginUpdates()
        var arrNewIndexPath = [IndexPath]()
        for i in itemsToDelete {
            arrNewIndexPath.append(i.indexPath)
        }
        for i in itemsToDelete {
            remove(item: i)
        }
        tableViewManager.tableView.deleteRows(at: arrNewIndexPath, with: animate)
        tableViewManager.tableView.endUpdates()
    }
    
    public func reload(_ animation: UITableView.RowAnimation) {
        
        if let index = tableViewManager.sections.firstIndex(where: {$0 == self}) {
            tableViewManager.tableView.reloadSections(IndexSet(integer: index), with: animation)
        }else{
            print("section did not in manager！")
        }
        
    }
    
}


