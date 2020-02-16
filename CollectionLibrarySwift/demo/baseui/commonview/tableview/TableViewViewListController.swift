//
//  HeaderViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/17.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class TableViewViewListController:AutoHeightUIViewController{
    
    var arrayM:NSMutableArray?
    var tableView: UITableView!
    var manager: YYTableViewManager!
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        self.tableView = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        self.view.addSubview(self.tableView);
        self.manager = YYTableViewManager(tableView: self.tableView)
        
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("commonview_tableview"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_driver"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_selection"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_expandableList"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_cal"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_sclaeheader"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_delete"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_multie"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tableview_complex"))
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler { selectItem in
                self.cellTapEvent(item: selectItem as! CommonTableItem )
            }
        }
        
        
        manager.reloadData()
    }
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            navigationController?.pushViewController(CustomDriverController(), animated: true)
        case 1:
            navigationController?.pushViewController(SelectionHeaderController(), animated: true)
        case 2:
            navigationController?.pushViewController(ExpandableListController(), animated: true)
        case 3:
            navigationController?.pushViewController(AutoCalHeightController(), animated: true)
        case 4:
            navigationController?.pushViewController(TableViewScaleHeaderController(), animated: true)
        case 5:
            navigationController?.pushViewController(DeleteController(), animated: true)
        case 6:
            navigationController?.pushViewController(MutileLayoutController(), animated: true)
        default:
            navigationController?.pushViewController(CategoryController(), animated: true)
        }
    }
    
}

