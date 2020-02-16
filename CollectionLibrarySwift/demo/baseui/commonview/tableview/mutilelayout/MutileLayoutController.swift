//
//  MutileLayoutController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class MutileLayoutController:AutoHeightUIViewController{
    
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
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_multie"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(PictureCell.self, PictureItem.self)
        manager.register(TextCell.self, TextItem.self)
        
        
        for index in 0...30{
            if(index%2==0){
                let picture = PictureItem()
                picture.content="因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。"
                picture.autoHeight(manager)
                section.add(item: picture)
            }else{
                let textItem = TextItem()
                textItem.content="天台山最高，动蹑赤城霞。何以静双目，扫山除妄花。"
                textItem.autoHeight(manager)
                section.add(item: textItem)
            }
            
            
        }
        manager.reloadData()
        
    }
}
