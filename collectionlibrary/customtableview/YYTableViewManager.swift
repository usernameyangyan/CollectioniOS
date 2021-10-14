//
//  YYTableViewManager.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit
@objc public protocol YYTableViewDelegate: NSObjectProtocol {
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView)
}

open class YYTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    public weak var delegate: YYTableViewDelegate?
    public var tableView: UITableView!
    public var sections: [YYTableViewSection] = []
    var defaultTableViewSectionHeight: CGFloat {
        return tableView.style == .grouped ? 44 : 0
    }
    
    public init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }
    
    
    /// use this method to update cell height after you change item.cellHeight.
    open func updateHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    public func register(_ nibClass: AnyClass, _ item: AnyClass, _ bundle: Bundle = Bundle.main) {
        if bundle.path(forResource: "\(nibClass)", ofType: "nib") != nil {
            tableView.register(UINib(nibName: "\(nibClass)", bundle: bundle), forCellReuseIdentifier: "\(item)")
        } else {
            tableView.register(nibClass, forCellReuseIdentifier: "\(item)")
        }
    }
    
    public func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let currentSection = sections[section]
        if currentSection.headerView != nil || (currentSection.headerHeight > 0 && currentSection.headerHeight != CGFloat.leastNormalMagnitude) {
            return currentSection.headerHeight
        }
        
        if let title = currentSection.headerTitle {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
            label.text = title
            label.font = UIFont.preferredFont(forTextStyle: .footnote)
            label.sizeToFit()
            return label.frame.height + 20.0
        } else {
            return defaultTableViewSectionHeight
        }
    }
    
    public func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentSection = sections[section]
        return currentSection.headerView
    }
    
    public func tableView(_: UITableView, willDisplayHeaderView _: UIView, forSection section: Int) {
        let (currentSection, _) = sectinAndItemFrom(indexPath: nil, sectionIndex: section, rowIndex: nil)
        currentSection?.headerWillDisplayHandler?(currentSection!)
    }
    
    public func tableView(_: UITableView, didEndDisplayingHeaderView _: UIView, forSection section: Int) {
        let (currentSection, _) = sectinAndItemFrom(indexPath: nil, sectionIndex: section, rowIndex: nil)
        currentSection?.headerDidEndDisplayHandler?(currentSection!)
    }
    
    public func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let currentSection = sections[section]
        return currentSection.footerHeight
    }
    
    public func tableView(_: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let currentSection = sections[section]
        return currentSection.footerView
    }
    
    public func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let (section, _) = sectinAndItemFrom(indexPath: nil, sectionIndex: section, rowIndex: nil)
        return section!.headerTitle
    }
    
    public func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        let (section, _) = sectinAndItemFrom(indexPath: nil, sectionIndex: section, rowIndex: nil)
        return section!.footerTitle
    }
    
    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = sections[section]
        return currentSection.items.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentSection = sections[indexPath.section]
        let item = currentSection.items[indexPath.row]
        #if swift(>=4.2)
        if item.cellHeight == UITableView.automaticDimension, tableView.estimatedRowHeight == 0 {
            tableView.estimatedRowHeight = 44
            tableView.estimatedSectionFooterHeight = 44
            tableView.estimatedSectionHeaderHeight = 44
        }
        #else
        if item.cellHeight == UITableViewAutomaticDimension, tableView.estimatedRowHeight == 0 {
            tableView.estimatedRowHeight = 44
            tableView.estimatedSectionFooterHeight = 44
            tableView.estimatedSectionHeaderHeight = 44
        }
        #endif
        
        var height=item.cellHeight
        if(lineView != nil){
            height = item.cellHeight + lineView!.frame.height
        }
        
        return height!
    }
    
    
    private var lineView:UIView?=nil
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = sections[indexPath.section]
        let item = currentSection.items[indexPath.row]
        item.tableViewManager = self
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier) as? YYTableViewCell
        
        if cell == nil {
            cell = YYTableViewCell(style: item.cellStyle!, reuseIdentifier: item.cellIdentifier)
        }
        
        if let title = item.cellTitle {
            cell?.textLabel?.text = title
        }
        
        if let separatorInset = item.separatorInset {
            cell?.separatorInset = separatorInset
        }
        
        if let accessoryType = item.accessoryType {
            cell?.accessoryType = accessoryType
        } else {
            cell?.accessoryType = .none
        }
        
        cell?.selectionStyle = item.selectionStyle
        
        cell?.item = item
        cell?.cellWillAppear()
        
        
        lineView=cell?.setCustomLineView(tableView.frame.width, item.cellHeight)
        if(lineView != nil){
            tableView.separatorStyle = .none
            cell!.addSubview(lineView!)
            cell!.contentView
                .top(equalTo: cell!.yy_top, constant:0)
                .bottom(equalTo: lineView!.yy_top, constant: 0)
                .left(equalTo: cell!.yy_left, constant: 0)
                .right(equalTo: cell!.yy_right, constant: 0)
                .build()
        }
        
        return cell!
    }
    
    public func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt _: IndexPath) {
        //        print("didEndDisplaying")
        (cell as! YYTableViewCell).cellDidDisappear()
    }
    
    public func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
        //        print("willDisplay")
        (cell as! YYTableViewCell).cellDidAppear()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = sections[indexPath.section]
        let item = currentSection.items[indexPath.row]
        if item.isAutoDeselect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        item.selectionHandler?(item)
    }
    
    public func tableView(_: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let (_, item) = sectinAndItemFrom(indexPath: indexPath, sectionIndex: nil, rowIndex: nil)
        return item!.editingStyle
    }
    
    public func tableView(_: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let (_, item) = sectinAndItemFrom(indexPath: indexPath, sectionIndex: nil, rowIndex: nil)
        
        if editingStyle == .delete {
            if let handler = item?.deletionHandler {
                handler(item!)
            }
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let d = delegate {
            if d.responds(to: #selector(YYTableViewDelegate.scrollViewDidScroll(_:))) {
                d.scrollViewDidScroll(scrollView)
            }
        }
    }
    
    func sectinAndItemFrom(indexPath: IndexPath?, sectionIndex: Int?, rowIndex: Int?) -> (YYTableViewSection?, YYTableViewItem?) {
        var currentSection: YYTableViewSection?
        var item: YYTableViewItem?
        if let idx = indexPath {
            currentSection = sections[idx.section]
            item = currentSection?.items[idx.row]
        }
        
        if let idx = sectionIndex {
            currentSection = sections.count > idx ? sections[idx] : nil
        }
        
        if let idx = rowIndex {
            item = (currentSection?.items.count)! > idx ? currentSection?.items[idx] : nil
        }
        
        return (currentSection, item)
    }
    
    public func add(section: YYTableViewSection) {
        if !section.isKind(of: YYTableViewSection.self) {
            print("error section class")
            return
        }
        section.tableViewManager = self
        sections.append(section)
    }
    
    public func remove(section: Any) {
        if !(section as AnyObject).isKind(of: YYTableViewSection.self) {
            print("error section class")
            return
        }
        sections.remove(at: sections.firstIndex(where: { (current) -> Bool in
            current == (section as! YYTableViewSection)
        })!)
    }
    
    public func removeAllSections() {
        sections.removeAll()
    }
    
    
    public func transform(fromLabel: UILabel?, toLabel: UILabel?) {
        toLabel?.text = fromLabel?.text
        toLabel?.font = fromLabel?.font
        toLabel?.textColor = fromLabel?.textColor
        toLabel?.textAlignment = (fromLabel?.textAlignment)!
        if let string = fromLabel?.attributedText {
            toLabel?.attributedText = string
        }
    }
    
    public func reloadData(){
        tableView.reloadData()
    }
}

