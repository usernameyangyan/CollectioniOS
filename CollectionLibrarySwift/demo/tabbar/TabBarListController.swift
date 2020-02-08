//
//  TabBarListController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/24.
//  Copyright © 2019 YoungManSter. All rights reserved.
//
import UIKit

class TabBarListController:YYIBaseTableViewController{
    
    var arrayM:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("tabbar"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_common"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_color_cumstom"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_with_nav"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_irrle"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_index"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_click_spring"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_click_bgchange"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_click_bgselect"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_click_bg_spcial"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_click_y"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_remind_default"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar_cumston_itemview"))

        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                self?.cellTapEvent(item: selectItem as! CommonTableItem )
            })
        }
        
    }
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            present(BasicCommonTabBar(), animated: true, completion: nil)
        case 1:
            present(TabBarCumstomColorController(), animated: true, completion: nil)
        case 2:
            present(TabBarWithNavigationBarController(), animated: true, completion: nil)
        case 3:
            present(TabBarIrregularityController(), animated: true, completion: nil)
        case 4:
            present(TabBarDefaultIndexController(), animated: true, completion: nil)
        case 5:
            present(TabBarSpringAnimationController(), animated: true, completion: nil)
        case 6:
             present(TabBarBgChangeAnimationController(), animated: true, completion: nil)
        case 7:
             present(TabBarBgBouncesController(), animated: true, completion: nil)
        case 8:
            present(TabBarBgHightlightController(), animated: true, completion: nil)
        case 9:
            present(TabBarRemindUseClickController(), animated: true, completion: nil)
        case 10:
            present(TabBarDefaultRemindController(), animated: true, completion: nil)
        case 11:
            present(CumstonBounceController(), animated: true, completion: nil)
        default:
            present(TabBarIrregularityController(), animated: true, completion: nil)
            
        }
    }
    
}
