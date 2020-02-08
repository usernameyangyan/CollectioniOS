//
//  TarBarBasicParam.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

private var instanceTarBar: TabBarBasicParamBuilder?
private var childs: [UIViewController]!
private var normals:[String]!
private var selects:[String]!
private var ts:[String]!

//默认设置
private var normalTextColor:UIColor=UIColor.gray
private var selectTextColor:UIColor=UIColor.systemBlue
private var normalImgColor:UIColor=UIColor.gray
private var selectImgColor:UIColor=UIColor.systemBlue
private var tabBarStyle:TabBarStyle = TabBarStyle.none
private var irregularityIndex:Int = -1
private var irregularityBorderColor:UIColor = UIColor.gray
private var irregularityBorderWidth:CGFloat = 3
private var irregularityBackgroundColor:UIColor = UIColor.systemBlue

private var normalItemColor:UIColor=UIColor.init(red: 37/255.0, green: 39/255.0, blue: 42/255.0, alpha: 1.0)
private var selectItemColor:UIColor=UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)

private var switchDefaultBackgroundSelectAnimation:Bool=false

private var tabClickAnimationStyle:TabBarClickAnimationStyle = TabBarClickAnimationStyle.none

//背景颜色特别设置
private var specialBgColorIndex:Int = -1
private var specialBgColor:UIColor = UIColor.init(red: 17/255.0, green: 86/255.0, blue: 136/255.0, alpha: 1.0)
private var specialSelectBgColor:UIColor = UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)

private var specialImgColor:UIColor = UIColor.white
private var specialSelectImgColor:UIColor=UIColor.white

private var remindClick:Int = -1


//MARK：自定义
private var cumstomTabBarItemView: [YYTabBarItemContentView]!

//MARK:TabBar使用默认样式还是自定义样式
public enum TabBarStyle : Int {
    case none
    case cumstom
}

//MARK：TabBar默认的点击动画
public enum TabBarClickAnimationStyle : Int {
    case none
    case bounces
    case backgroundcolorWithoutTitles
}

//MARK：使用默认还是自定义
public class TabBarBasicParamBuilder{
    
    
    class func with(childVCs: [UIViewController],normalImgs:[String],selectImgs:[String],titles:[String]) -> TabBarBasicParamBuilder{
        instanceTarBar = TabBarBasicParamBuilder()
        childs=childVCs
        normals=normalImgs
        selects=selectImgs
        ts=titles
        
        return instanceTarBar!
    }
    
    private init(){
        resetData()
    }
    
    private func resetData(){
        normalTextColor=UIColor.gray
        selectTextColor=UIColor.systemBlue
        normalImgColor=UIColor.gray
        selectImgColor=UIColor.systemBlue
        tabBarStyle = TabBarStyle.none
        irregularityIndex = -1
        irregularityBorderColor = UIColor.gray
        irregularityBorderWidth = 3
        irregularityBackgroundColor = UIColor.systemBlue
        tabClickAnimationStyle = TabBarClickAnimationStyle.none
        normalItemColor=UIColor.init(red: 37/255.0, green: 39/255.0, blue: 42/255.0, alpha: 1.0)
        selectItemColor=UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)
        switchDefaultBackgroundSelectAnimation=false
        
        specialBgColorIndex = -1
        
        specialBgColor = UIColor.init(red: 17/255.0, green: 86/255.0, blue: 136/255.0, alpha: 1.0)
        
        specialSelectBgColor = UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)
        
        specialImgColor = UIColor.white
        specialSelectImgColor=UIColor.white
        
        remindClick = -1
        
    }
    
    func getChildVs()->[UIViewController]{
        return childs
    }
    
    
    func getNormalImgs() -> [String] {
        return normals
    }
    
    func getSelectImgs() -> [String] {
        return selects
    }
    
    func getTitles() -> [String]{
        return ts
    }
    
    func setTitles(titles:[String]?){
        ts=titles
    }
    
    
    func getTabBarStyle() -> TabBarStyle {
        return tabBarStyle
    }
    
    
    
    //MARK:获取默认设置
    
    func defultStyle()->DefuletStyle{
        return DefuletStyle()
    }
    
    
    
    class DefuletStyle{
        
        
        func setTextColor(txtColor:UIColor)->DefuletStyle{
            normalTextColor=txtColor
            return self
        }
        
        func getTextColor() -> UIColor {
            return normalTextColor
        }
        
        func setSelectTextColor(selectTxtColor:UIColor)->DefuletStyle{
            selectTextColor=selectTxtColor
            return self
        }
        
        func getSelectTextColor() -> UIColor {
            return selectTextColor
        }
        
        func setImgColor(imageColor:UIColor)->DefuletStyle{
            normalImgColor=imageColor
            return self
        }
        
        func getImgColor() -> UIColor {
            return normalImgColor
        }
        
        func setSelectImgColor(selectImageColor:UIColor)->DefuletStyle{
            selectImgColor=selectImageColor
            return self
        }
        
        func getSelectImgColor() -> UIColor {
            return selectImgColor
        }
        
        
        func irregularity()->Irregularity{
            return Irregularity(defaultStyleInstance: self)
        }
        
        class Irregularity{
            private var defaultStyleInstance:DefuletStyle
            
            init(defaultStyleInstance:DefuletStyle) {
                self.defaultStyleInstance=defaultStyleInstance
            }
            
            func setIrregularityIndex(irregularIndex:Int)->Irregularity {
                irregularityIndex=irregularIndex
                return self
            }
            
            func getIrregularityIndex()->Int{
                return irregularityIndex
            }
            
            func setIrregularityBorderColor(borderColor:UIColor) -> Irregularity {
                irregularityBorderColor=borderColor
                return self
            }
            
            func getIrregularityBorderColor()->UIColor{
                return irregularityBorderColor
            }
            
            func setIrregularityBorderWidth(borderWidth:CGFloat) -> Irregularity {
                irregularityBorderWidth=borderWidth
                return self
            }
            
            func getIrregularityBorderWidth()->CGFloat{
                return irregularityBorderWidth
            }
            
            func setIrregularityBackgroundColor(backgroundColor:UIColor) -> Irregularity {
                irregularityBackgroundColor=backgroundColor
                return self
            }
            
            func getIrregularityBackgroundColor()->UIColor{
                return irregularityBackgroundColor
            }
            
            //结束语句
            open func retunDefaultStyle()->DefuletStyle{
                return self.defaultStyleInstance
            }
            
        }
        
        
        
        
        func bouncesAnimationStyle()->DefuletStyle{
            tabClickAnimationStyle=TabBarClickAnimationStyle.bounces
            return self
        }
        
        
        func getClickAnimationStyle() -> TabBarClickAnimationStyle {
            return tabClickAnimationStyle
        }
        
        
        func setRemindUseClickIndex(remindUseClickIndex:Int) -> DefuletStyle {
            remindClick=remindUseClickIndex
            return self
        }
        
        func getRemindUseClickIndex()->Int{
            return remindClick
        }
        
        func backgroundColorWithoutTitlesAnimationStyle()->BackgroundColorAnimationStyle{
            tabClickAnimationStyle=TabBarClickAnimationStyle.backgroundcolorWithoutTitles
            return BackgroundColorAnimationStyle(defaultStyleInstance: self)
        }
        
        //MARK:背景动画
        class BackgroundColorAnimationStyle{
            
            private var defaultStyleInstance:DefuletStyle
            
            init(defaultStyleInstance:DefuletStyle) {
                self.defaultStyleInstance=defaultStyleInstance
            }
            
            func setItemBgColor(normalItemBgColor:UIColor) -> BackgroundColorAnimationStyle{
                normalItemColor=normalItemBgColor
                return self
            }
            
            func getItemBgColor() -> UIColor{
                return normalItemColor
            }
            
            func setSelectItemBgColor(selectItemBgColor:UIColor) -> BackgroundColorAnimationStyle{
                selectItemColor=selectItemBgColor
                return self
            }
            
            func getSelectItemBgColor() -> UIColor{
                return selectItemColor
            }
            
            func setSwithcBouncesAnimation(switchBgAnimation:Bool) -> BackgroundColorAnimationStyle{
                switchDefaultBackgroundSelectAnimation=switchBgAnimation
                return self
            }
            
            func getSwithcBouncesAnimation() -> Bool{
                return switchDefaultBackgroundSelectAnimation
            }
            
            func setSpecialIndexAndColor(bgColorIndex:Int,bgColor:UIColor=UIColor.init(red: 17/255.0, green: 86/255.0, blue: 136/255.0, alpha: 1.0),selectBgColor:UIColor=UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0),imgColor:UIColor=UIColor.white,selectImgColor:UIColor=UIColor.white)->BackgroundColorAnimationStyle{
                specialBgColorIndex=bgColorIndex
                specialBgColor=bgColor
                specialSelectBgColor=selectBgColor
                specialImgColor = imgColor
                specialSelectImgColor = selectImgColor
                return self
            }
            
            func getSpecialBgColorIndex()->Int{
                return specialBgColorIndex
            }
            
            func getSpecialBgColor()->UIColor{
                return specialBgColor
            }
            
            func getSpecialSelectBgColor()->UIColor{
                return specialSelectBgColor
            }
            
            func getSpecialSelectImgColor()->UIColor{
                return specialSelectImgColor
            }
            
            func getSpecialImgColor()->UIColor{
                return specialImgColor
            }
            
            //结束语句
            open func retunDefaultStyle()->DefuletStyle{
                return self.defaultStyleInstance
            }
        }
        
        
        //结束语句
        open func build()->TabBarBasicParamBuilder{
            tabBarStyle=TabBarStyle.none
            return instanceTarBar!
        }
    }
    
    
    
    
    //MARK:自定义设置
    func cumstomStyle()->CumstomStyle{
        return CumstomStyle()
        
    }
    
    class CumstomStyle{
    
        func setCumstonTabBarItemView(cumstomItemView: [YYTabBarItemContentView]) -> CumstomStyle {
            cumstomTabBarItemView=cumstomItemView
        
            return self
        }
        
        func getCumstonTabBarItemView() -> [YYTabBarItemContentView] {
            return cumstomTabBarItemView
        }
        
        
        //结束语句
        open func build()->TabBarBasicParamBuilder{
            tabBarStyle=TabBarStyle.cumstom
            return instanceTarBar!
        }
    }
    
}
