//
//  RefreshListViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit


class RefreshListViewController:YYIBaseTableViewController{
    var arrayM:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("refresh"))
            .build()
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        arrayM?.add("默认下拉刷新/上拉加载样式")
        arrayM?.add("自定义下拉刷新/上拉加载样式")
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                self?.cellTapEvent(item: selectItem as! CommonTableItem )
            })
        }
        
        manager.reloadData()
        
    }
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            navigationController?.pushViewController(DefaultRefreshViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(CumstonRefreshViewController(), animated: true)
        default:
            break
        }
    }
}
