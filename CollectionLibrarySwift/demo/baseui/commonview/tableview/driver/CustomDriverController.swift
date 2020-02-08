//
//  CustomDriverController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CustomDriverController:YYIBaseTableViewController{
    var arrayM:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_driver"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
    
        
        tableView.separatorStyle = .none
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CustomDriverCell.self, CustomDriverItem.self)
        
        //数据组装
        self.arrayM=NSMutableArray()
        
        for index in 0 ..< 5 {
            self.arrayM!.add(String.init(format:"测试%1d",index))
        }
        
        for str in arrayM!{
            let item = CustomDriverItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
        }
        
    }
}
