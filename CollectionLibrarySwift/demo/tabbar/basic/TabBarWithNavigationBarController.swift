//
//  TabBarWithNavigationBarController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class TabBarWithNavigationBarController:YYTabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let normalImgs=["home","find","favor","message","me"]
        let selectImgs=["home_1","find_1","favor_1","message_1","me_1"]
        let titles=["首页","搜索","收藏","消息","我的"]
        
        
        let chidVC: [UIViewController] = titles.map { _ in
            UIViewController.autoHeight=UIScreen.main.bounds.height - self.tabBar.frame.height
            let vc: CommonWithNavController = CommonWithNavController()
            return vc
        }
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .build()
        
        
        let _:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        
    }
}
