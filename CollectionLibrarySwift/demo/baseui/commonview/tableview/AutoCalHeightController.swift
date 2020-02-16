//
//  AutoCalHeightController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class AutoCalHeightController:AutoHeightUIViewController{
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
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_cal"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        
        self.arrayM!.add("因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。")
        self.arrayM!.add("山有木兮木有枝，心悦君兮君不知。——佚名《越人歌》"); self.arrayM!.add("永远不要欺骗女人，因为我们一眼就能看穿。你知道男人和女人，说谎的最大差别在哪里吗？男人说谎是要让自己觉得好过而女人说谎呢是要让对方好过，我们选择欺骗，是因为不想伤害深爱的人，我们不是故意的，只是没有伤害对方的勇气，所以才隐藏真正的答案。")
        self.arrayM!.add("妾有琵琶谱。抱金槽、慢捻轻抛，柳梢莺妒。羽调六么弹遍了，花底灵犀暗度。奈敲断、玉钗纤股。低画屏深朱户掩，卷西风、满地吹尘土。芳事往，蝶空诉。")
        self.arrayM!.add("天台山最高，动蹑赤城霞。何以静双目，扫山除妄花。")
        
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
        }
        
        manager.reloadData()
        
    }
}
