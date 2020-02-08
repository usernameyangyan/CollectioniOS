//
//  Test1.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/24.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CommonWithNavController:YYIBaseTableViewController{
    var arrayM:NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(cumstonItem: BackBarButtonItem.init(image:UIImage(named: "back_btn"), style: .plain, target: self, action: #selector(click)),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("tabbar_use"))
            .build()
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        
        
        for _ in 0...20{
            self.arrayM!.add("因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。")
        }
        
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
        }
        
    }
    
    
    
    @objc func click(){
        dismiss(animated: true, completion: nil)
    }
    
}
