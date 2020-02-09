//
//  iPhoneUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/10.
//  Copyright © 2019 YoungManSter. All rights reserved.
//
//
import UIKit
open class IPhoneUtils{
    public static var BAR_HEIGHT:CGFloat=isIphoneX() ? 88 : 64
    
    //获取顶部导航栏高度
    static func getNavBarHeight()->CGFloat{
        return BAR_HEIGHT
    }
    

    //判断是否是iphonex以上
    public static func isIphoneX()-> Bool{
        let screenHeight = UIScreen.main.nativeBounds.size.height;
        if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
            return true
        }
        return false
    }
}
