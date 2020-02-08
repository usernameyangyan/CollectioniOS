//
//  ExpandableListController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class ExpandableListController:YYIBaseTableViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_expandableList"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(ExpanableListCell1.self, ExpanableListItem1.self)
        manager.register(ExpanableListCell2.self, ExpanableListItem2.self)
        manager.register(ExpanableListCell3.self, ExpanableListItem3.self)
        
        
        // level 0
        let item0 = ExpanableListItem1()
        item0.level = 0
        section.add(item: item0)
        // 如果isExpand为true，则下一级的item（也就是item1）必须加入section
        item0.isExpand = true
        // level 1
        for _ in 0 ..< 3 {
            let item1 = ExpanableListItem2()
            // level仅用于记录层级，可以不赋值
            item1.level = 1
            item1.isExpand = false
            section.add(item: item1)
            item0.arrNextLevel.append(item1)

            // level 2
            for _ in 0 ..< 3 {
                let item2 = ExpanableListItem3()
                // 如果isExpand为false，则后面就不用把item加入section
                item2.isExpand = false
                item1.arrNextLevel.append(item2)
            }
        }
    }
}
