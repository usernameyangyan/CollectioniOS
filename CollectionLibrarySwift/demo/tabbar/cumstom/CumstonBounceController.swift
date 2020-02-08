//
//  CumstomBounceController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CumstonBounceController:YYTabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let normalImgs=["home","find","favor","message","me"]
        let selectImgs=["home_1","find_1","favor_1","message_1","me_1"]
        let titles=["首页","搜索","收藏","消息","我的"]
        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        let cumstonRemindItemView=CumstonRemindItemView()
        let cumstonItemView=[CumstonSettingItemView(),CumstonAnimateWithTipsContentView(),CumstonAnimateWithNumContentView(),CumstonAnimateWithImgContentView(),cumstonRemindItemView]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .cumstomStyle()
            .setCumstonTabBarItemView(cumstomItemView: cumstonItemView)
            .build()
        
        
        let tab:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        
        tab.setShouldHijackHandler(shouldHijackHandler: {
            tabBarController,viewController,index in
            if(index==4){
                cumstonRemindItemView.hideRemindTip()
            }
            return false
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            tab.setTabBarBadgeValue(index: 0, badgeValue: "New")
            tab.setTabBarBadgeValue(index: 1, badgeValue: "99+")
            tab.setTabBarBadgeValue(index: 2, badgeValue: "1")
            tab.setTabBarBadgeValue(index: 3, badgeValue: "99+")
            
        }
        
        
    }
}
