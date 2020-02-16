//
//  BaseFunctionListController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


class BaseFunctionController:AutoHeightUIViewController{
    
    var arrayM:NSMutableArray?
    var tableView: UITableView!
    var manager: YYTableViewManager!
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        self.view.addSubview(self.tableView);
        self.manager = YYTableViewManager(tableView: self.tableView)
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("base_setting"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add(InternationalUtils.getInstance.getString("language_setting"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("app_language_setting"))
        
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
            navigationController?.pushViewController(MultiLanguageViewController(), animated: true)
        default:
            navigationController?.pushViewController(AppNameMultiLanguageViewController(), animated: true)
        }
    }
    
}



