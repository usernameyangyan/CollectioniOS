//
//  TabBarRemindController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class TabBarDefaultRemindController:YYTabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let normalImgs=["home","find","favor","message","me"]
        let selectImgs=["home_1","find_1","favor_1","message_1","me_1"]
        let titles=["首页","搜索","收藏","消息","我的"]
        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .build()
        
        let tabBar:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        
        
        tabBar.setTabBarBadgeValue(index: 0, badgeValue: "99+")
        tabBar.setTabBarBadgeValue(index: 1, badgeValue: " ")
        tabBar.setTabBarBadgeValue(index: 2, badgeValue: "")
        tabBar.setTabBarBadgeValue(index: 3, badgeValue: "New")
        tabBar.setTabBarBadgeValue(index:4, badgeValue: "1")
        tabBar.setTabBarBadgeValueColor(index: 4, color: UIColor.blue)
        
        
        tabBar.setShouldHijackHandler(shouldHijackHandler: {
            tabBarController,viewController,index in
            
            if(index==2){
                tabBar.hideTabBadgeValue(index: 2)
            }else if(index==4){
                tabBar.setTabBarBadgeValueColor(index: 4, color: UIColor.red)
            }
            return false
        })
        
    }
    
}
