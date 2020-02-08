//
//  SelectionHeaderController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class SelectionHeaderController:UIViewController{
    
    var tableView: UITableView!
    var manager: YYTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_selection"))
            .build()
        
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        
        manager = YYTableViewManager(tableView: tableView)
        
        for i in 0 ... 8 {
            let headerView:SelectionHeader=SelectionHeader.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            headerView.setContent(con: "Header " + String(i))
            let section = YYTableViewSection.init(headerView: headerView)
            manager.add(section: section)
            
            
            for j in 0 ... 4 {
                section.add(item: YYTableViewItem(title: "Header " + String(i) + " Row " + String(j)))
            }
        }
        
    }
}
