//
//  NavShowViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class NavShowViewController:AutoHeightUIViewController{
    
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
            .setBarBackgroundColor(barTintColor: UIColor.red)
            .setTitle(title: InternationalUtils.getInstance.getString("nav_use"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        tableView.separatorStyle = .none
        
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(NavigationViewSwitchCell.self, NavigationViewSwitchItem.self)
        manager.register(NavigationViewSliderCell.self, NavigationViewSliderItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_hidden"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_alpha"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_backgroundcolor"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_titlecolor"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_bar_img"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_shadow"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_trance"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_title"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_title_size"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_rightitem"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("nav_leftitem"))
        
        
        for str in arrayM!{
            
            if(str as? String == InternationalUtils.getInstance.getString("nav_alpha")){
                let sliderItem = NavigationViewSliderItem()
                sliderItem.content=str as? String
                sliderItem.vc=self
                section.add(item: sliderItem)
            }else{
                let switchItem = NavigationViewSwitchItem()
                switchItem.content=str as? String
                switchItem.vc=self
                section.add(item: switchItem)
            }
            
            
        }
        
        manager.reloadData()
        
        
    }
    
}
