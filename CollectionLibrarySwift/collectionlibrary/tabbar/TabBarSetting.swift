//
//  TabBarUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/24.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


public class TabBarSetting{
    
    private var vc:YYTabBarController
    private var tabBarBarBasicParamBuilder:TabBarBasicParamBuilder
    
    
    init(vc:YYTabBarController,tabBarBuilder:TabBarBasicParamBuilder) {
        self.tabBarBarBasicParamBuilder=tabBarBuilder
        self.vc=vc
        initBaseParam()
    }
    
    
    
    private func initBaseParam(){
        if(tabBarBarBasicParamBuilder.defultStyle().getClickAnimationStyle()==TabBarClickAnimationStyle.backgroundcolorWithoutTitles && tabBarBarBasicParamBuilder.getTabBarStyle()==TabBarStyle.none){
            if let tabBar = vc.tabBar as? YYTabBar {
                tabBar.itemCustomPositioning = .fillIncludeSeparator
            }
            tabBarBarBasicParamBuilder.setTitles(titles: [])
            
        }
        
        
        setTabBarBackgroundColor(barTintColor: UIColor.white)
        
        let count=tabBarBarBasicParamBuilder.getChildVs().count-1
        for index in 0...count{
            
            if(tabBarBarBasicParamBuilder.getTabBarStyle()==TabBarStyle.none){

                let baseItemView:YYTabBarItemContentView
                let title:String
                if(tabBarBarBasicParamBuilder.defultStyle().irregularity().getIrregularityIndex()>0&&index==tabBarBarBasicParamBuilder.defultStyle().irregularity().getIrregularityIndex()){
                    baseItemView=BasicIrregularityContentView()
                    (baseItemView as! BasicIrregularityContentView) .setBasicSetting(tabBuilder: tabBarBarBasicParamBuilder,specialIndex: index)
                    
                    title=""
                    
                }else{
                    baseItemView=BasicTabBarItemContentView()
                    (baseItemView as! BasicTabBarItemContentView).setBasicSetting(tabBuilder: tabBarBarBasicParamBuilder,specialIndex: index)
                    
                    if(tabBarBarBasicParamBuilder.getTitles()==[]||tabBarBarBasicParamBuilder.defultStyle().getClickAnimationStyle() == .backgroundcolorWithoutTitles){
                        title=""
                    }else{
                        title=tabBarBarBasicParamBuilder.getTitles()[index]
                    }
                }
                
                if(title==""){
                    tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem = YYTabBarItem.init(baseItemView,title: nil, image: UIImage(named: tabBarBarBasicParamBuilder.getNormalImgs()[index]), selectedImage: UIImage(named: tabBarBarBasicParamBuilder.getSelectImgs()[index]))
                }else{
                    tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem = YYTabBarItem.init(baseItemView,title: title, image: UIImage(named: tabBarBarBasicParamBuilder.getNormalImgs()[index]), selectedImage: UIImage(named: tabBarBarBasicParamBuilder.getSelectImgs()[index]))
                }
                
            }else{//MARK:自定义样式
                            
                let title:String
                if(tabBarBarBasicParamBuilder.getTitles()==[]){
                    
                    title=""
                    
                }else{
                    title=tabBarBarBasicParamBuilder.getTitles()[index]
                }
                
                if(title==""){
                    tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem = YYTabBarItem.init(tabBarBarBasicParamBuilder.cumstomStyle().getCumstonTabBarItemView()[index],title: nil, image: UIImage(named: tabBarBarBasicParamBuilder.getNormalImgs()[index]), selectedImage: UIImage(named: tabBarBarBasicParamBuilder.getSelectImgs()[index]))
                }else{
                    tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem = YYTabBarItem.init(tabBarBarBasicParamBuilder.cumstomStyle().getCumstonTabBarItemView()[index],title: title, image: UIImage(named: tabBarBarBasicParamBuilder.getNormalImgs()[index]), selectedImage: UIImage(named: tabBarBarBasicParamBuilder.getSelectImgs()[index]))
                }
                
                
            }
        }
        
        
        let arrayM=NSMutableArray()
        for index in 0...count{
            let nav=UINavigationController.init(rootViewController: tabBarBarBasicParamBuilder.getChildVs()[index])
            arrayM.add(nav)
        }
        vc.navigation.bar.isHidden=true
        vc.viewControllers=arrayM as! [UINavigationController]
        
    }
    
    
    //MARK：设置背景颜色
    func setTabBarBackgroundColor(barTintColor:UIColor) {
        vc.tabBar.barTintColor=barTintColor
    }
    
    //MARK:设置背景图片
    func setTabBarBackgroundImage(backgroundImage:UIImage?) {
        vc.tabBar.backgroundImage=backgroundImage
    }
    
    //MARK:点击回调
    func setShouldHijackHandler(shouldHijackHandler: YYTabBarControllerShouldHijackHandler?){
        vc.shouldHijackHandler=shouldHijackHandler
    }
    
    
    func setDidHijackhHandler(didHijackHandler:YYTabBarControllerDidHijackHandler?) {
        vc.didHijackHandler=didHijackHandler
    }
    
    //MARK:设置默认显示TabBarItem
    func setDefaultTabIndex(index:Int){
        vc.selectedIndex=index
    }
    
    //MARK:设置提示内容
    func setTabBarBadgeValue(index:Int,badgeValue:String){
        tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem.badgeValue=badgeValue
    }
    
    //MARK:隐藏提示内容
    func hideTabBadgeValue(index:Int){
        tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem.badgeValue=nil
    }
    
    //MARK:设置提示演示
    func setTabBarBadgeValueColor(index:Int,color:UIColor) {
        tabBarBarBasicParamBuilder.getChildVs()[index].tabBarItem.badgeColor=color
    }
    
}

