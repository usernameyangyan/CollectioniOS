//
//  DefaultRefreshViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit


class DefaultRefreshViewController:YYIBaseTableViewController{
    var array = [String]()
    var page = 1
    let section = YYTableViewSection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: "默认下拉刷新/上拉加载样式")
            .build()
        
        
        tableView.separatorStyle = .none
        
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        let refreshView:YYDefaultRefreshHeaderAnimator=YYDefaultRefreshHeaderAnimator.init(frame: .zero)
        let footView:YYDefaultRefreshFooterAnimator=YYDefaultRefreshFooterAnimator.init(frame: .zero)
        
        self.tableView.yy.addPullToRefreshListener(animator: refreshView, handler: {
            [weak self] in
            self?.refresh()
            },aboveView: navigation.bar,childView: self.tableView)
        
        self.tableView.yy.addLoadMoreListener(animator: footView){
            [weak self] in
            self?.loadMore()
        }
        
        
        for _ in 1...10{
            let item = CommonTableItem()
            item.desc="因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。"
            item.autoHeight(manager)
            section.add(item: item)
        }
        
    }
    
    
    //MARK:下拉刷新
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.page = 1
            self.section.removeAllItems()
            for _ in 1...10{
                let item = CommonTableItem()
                item.desc="因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。"
                item.autoHeight(self.manager)
                self.section.add(item: item)
            }
            self.tableView.reloadData()
            
            self.tableView.yy.stopPullToRefresh()
        }
    }
    
    
    func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.page += 1
            
            if self.page < 3{
                for _ in 1...10{
                    let item = CommonTableItem()
                    item.desc="因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。"
                    item.autoHeight(self.manager)
                    self.section.add(item: item)
                }
                
                self.tableView.reloadData()
                self.tableView.yy.stopLoadingMore()
                
            } else {
                self.tableView.yy.noticeNoMoreData()
            }
            
            
            
        }
    }
}
