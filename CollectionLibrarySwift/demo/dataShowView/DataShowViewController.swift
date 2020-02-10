//
//  DataShowViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/4.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DataShowViewController:YYIBaseTableViewController{
    
    var arrayM:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"通用数据加载显示样式")
            .build()
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        //数据组装
        self.arrayM=NSMutableArray()
        arrayM?.add("默认没有数据加载显示样式(可根据需要修改对应参数)")
        arrayM?.add("默认没有网络加载显示样式(可根据需要修改对应参数)")
        arrayM?.add("默认加载数据显示样式(可根据需要修改对应参数)")
        arrayM?.add("自定义加载显示样式")
        arrayM?.add("使用demo")
        
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
            navigationController?.pushViewController(DefaultNoDataViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(DefaultNoNetWorkViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(DefaultLoadingViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(CustomDataShowVIewController(), animated: true)
        case 4:
            navigationController?.pushViewController(DataShowViewDemoViewController(), animated: true)
        default:
            break
        }
    }
}


